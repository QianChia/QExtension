//
//  QProgressButton.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QProgressButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface QProgressButton ()

/// 进度值
@property (nonatomic, assign) CGFloat progress;

/// 线宽
@property (nonatomic, assign) CGFloat lineWidth;

/// 线颜色
@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation QProgressButton

/// 创建带进度条的按钮
+ (instancetype)q_progressButtonWithFrame:(CGRect)frame
                                 progress:(CGFloat)progress
                                lineWidth:(CGFloat)lineWidth
                                lineColor:(nullable UIColor *)lineColor
                          backgroundColor:(nullable UIColor *)backgroundColor {
    
    QProgressButton *progressButton = [[self alloc] init];
    
    progressButton.frame = frame;
    progressButton.progress = progress;
    progressButton.lineWidth = lineWidth ? : 2;
    progressButton.lineColor = lineColor ? : [UIColor orangeColor];
    
    progressButton.layer.cornerRadius = MIN(progressButton.bounds.size.width,
                                            progressButton.bounds.size.height) * 0.5;
    progressButton.layer.masksToBounds = YES;
    
    progressButton.backgroundColor = backgroundColor ? : [UIColor clearColor];
    
    [progressButton setTitle:[NSString stringWithFormat:@"%.0f%%", progress * 100]
                    forState:UIControlStateNormal];
    
    [progressButton setNeedsDisplay];
    
    return progressButton;
}

- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat r = (MIN(rect.size.width, rect.size.height) - self.lineWidth) * 0.5;
    CGFloat start = - M_PI_2;
    CGFloat end = self.progress * 2 * M_PI + start;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:r
                                                    startAngle:start
                                                      endAngle:end
                                                     clockwise:YES];
    
    path.lineWidth = self.lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    
    [self.lineColor setStroke];
    
    [path stroke];
}

@end


NS_ASSUME_NONNULL_END
