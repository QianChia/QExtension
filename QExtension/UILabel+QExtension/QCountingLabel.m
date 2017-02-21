//
//  QCountingLabel.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/19.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QCountingLabel.h"

NS_ASSUME_NONNULL_BEGIN


#define COUNTER_RATE  3.0


@interface QCountingLabel ()

@property (nonatomic, assign) CGFloat startingValue;
@property (nonatomic, assign) CGFloat destinationValue;
@property (nonatomic, assign) NSTimeInterval progress;
@property (nonatomic, assign) NSTimeInterval lastUpdate;
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) CGFloat easingRate;

@property (nonatomic, strong, nullable) CADisplayLink *timer;

@end

@implementation QCountingLabel

#pragma mark - 文本数字变化方法

/// 创建 QCountingLabel 对象
+ (instancetype)q_countingLabelWithFrame:(CGRect)frame
                                  format:(NSString *)format
                          positiveFormat:(nullable NSString *)positiveFormat
                                  method:(QCountingMethod)method
                               fromValue:(CGFloat)startValue
                                 toValue:(CGFloat)endValue
                            withDuration:(NSTimeInterval)duration 
                              completion:(void (^)())completion {
    
    QCountingLabel *label = [[self alloc] initWithFrame:frame];
    
    label.format = format;
    label.positiveFormat = positiveFormat;
    label.method = method;
    label.completionBlock = completion;
    [label q_countFromValue:startValue toValue:endValue withDuration:duration];
    
    return label;
}

/// 文本数字从起始值变化到结束值
- (void)q_countFromValue:(CGFloat)startValue toValue:(CGFloat)endValue {
    
    if (self.animationDuration == 0.0f) {
        self.animationDuration = 2.0f;
    }
    
    [self q_countFromValue:startValue toValue:endValue withDuration:self.animationDuration];
}

/// 文本数字在指定时间内从起始值变化到结束值
- (void)q_countFromValue:(CGFloat)startValue toValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    
    self.startingValue = startValue;
    self.destinationValue = endValue;
    
    // remove any (possible) old timers
    [self.timer invalidate];
    self.timer = nil;
    
    if (duration == 0.0) {
        
        // No animation
        [self q_setTextValue:endValue];
        
        if (self.completionBlock) {
            self.completionBlock();
        }
        
        return;
    }
    
    self.easingRate = 3.0f;
    self.progress = 0;
    self.totalTime = duration;
    self.lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    
    if (self.format == nil) {
        self.format = @"%f";
    }
    
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(q_timerUpdate:)];
    timer.frameInterval = 2;
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.timer = timer;
}

/// 文本数字从当前值变化到结束值
- (void)q_countFromCurrentValueToValue:(CGFloat)endValue {
    
    [self q_countFromValue:[self q_getCurrentValue] toValue:endValue];
}

/// 文本数字在指定时间内从当前值变化到结束值
- (void)q_countFromCurrentValueToValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    
    [self q_countFromValue:[self q_getCurrentValue] toValue:endValue withDuration:duration];
}

/// 文本数字从 0 变化到结束值
- (void)q_countFromZeroToValue:(CGFloat)endValue {
    
    [self q_countFromValue:0.0f toValue:endValue];
}

/// 文本数字在指定时间内从 0 变化到结束值
- (void)q_countFromZeroToValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration {
    
    [self q_countFromValue:0.0f toValue:endValue withDuration:duration];
}

/// format setter
- (void)setFormat:(NSString *)format {
    
    _format = format;
    
    // update label with new format
    [self q_setTextValue:self.q_getCurrentValue];
}

#pragma mark - 助手方法

/// 定时器定时响应事件处理
- (void)q_timerUpdate:(NSTimer *)timer {
    
    // update progress
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    self.progress += now - self.lastUpdate;
    self.lastUpdate = now;
    
    if (self.progress >= self.totalTime) {
        [self.timer invalidate];
        self.timer = nil;
        self.progress = self.totalTime;
    }
    
    [self q_setTextValue:[self q_getCurrentValue]];
    
    if (self.progress == self.totalTime) {
        if (self.completionBlock) {
            self.completionBlock();
        }
    }
}

/// 设置数值
- (void)q_setTextValue:(CGFloat)value {
    
    if (self.attributedFormatBlock != nil) {
        
        self.attributedText = self.attributedFormatBlock(value);
        
    } else if (self.formatBlock != nil) {
        
        self.text = self.formatBlock(value);
        
    } else {
        
        // check if counting with ints - cast to int
        if ([self.format rangeOfString:@"%(.*)d" options:NSRegularExpressionSearch].location != NSNotFound ||
            [self.format rangeOfString:@"%(.*)i"].location != NSNotFound) {
            
            // 整型样式
            self.text = [NSString stringWithFormat:self.format, (int)value];
            
        } else if (self.positiveFormat.length > 0) {
            
            // 带千分位分隔符的浮点型样式
            NSString *str = [NSString stringWithFormat:self.format, value];
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            [formatter setPositiveFormat:self.positiveFormat];
            NSString *formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[str floatValue]]];
            
            self.text = formatterString;
            
        } else {
            
            // 普通浮点型样式
            self.text = [NSString stringWithFormat:self.format, value];
        }
    }
}

/// 获取当前值
- (CGFloat)q_getCurrentValue {
    
    if (self.progress >= self.totalTime) {
        return self.destinationValue;
    }
    
    CGFloat percent = self.progress / self.totalTime;
    CGFloat updateVal = [self update:percent];
    
    return self.startingValue + (updateVal * (self.destinationValue - self.startingValue));
}

/// 更新数值
- (CGFloat)update:(CGFloat)t {
    
    switch (self.method) {
            
        case QCountingMethodEaseInOut: {
            
            int sign = 1;
            int r = (int)COUNTER_RATE;
            
            if (r % 2 == 0) {
                sign = -1;
            }
            
            t *= 2;
            
            if (t < 1) {
                return 0.5f * powf(t, COUNTER_RATE);
            } else {
                return sign * 0.5f * (powf(t - 2, COUNTER_RATE) + sign * 2);
            }
            
            break;
        }
            
        case QCountingMethodEaseIn: {
            
            return powf(t, COUNTER_RATE);
            
            break;
        }
            
        case QCountingMethodEaseOut: {
            
            return 1.0 - powf((1.0 - t), COUNTER_RATE);
            
            break;
        }
            
        case QCountingMethodLinear: {
            
            return t;
            
            break;
        }
            
        default:
            return t;
    }
}

@end


NS_ASSUME_NONNULL_END
