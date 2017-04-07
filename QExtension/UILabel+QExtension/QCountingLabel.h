//
//  QCountingLabel.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/19.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 文本数字变化方式枚举
typedef NS_ENUM(NSUInteger, QCountingMethod) {
    
    QCountingMethodEaseInOut,     // 渐进渐出，开始结束慢，中间快
    QCountingMethodEaseIn,        // 渐进，开始慢，结束快
    QCountingMethodEaseOut,       // 渐出，开始快，结束慢
    QCountingMethodLinear         // 线性，匀速
};

@interface QCountingLabel : UILabel

/// 文本数字样式，默认为 @"%f"
@property (nonatomic, strong) IBInspectable NSString *format;

/// 文本数字分隔符样式，例如 @"###,###.##"
@property (nonatomic, strong) IBInspectable NSString *positiveFormat;

/// 文本数字变化方式，默认为 EaseInOut
@property (nonatomic, assign) IBInspectable QCountingMethod method;

/// 文本数字变化时间，默认为 2.0
@property (nonatomic, assign) IBInspectable NSTimeInterval animationDuration;

/// 文本数字样式 Block
@property (nonatomic, copy) NSString *(^formatBlock)(CGFloat);

/// 富文本数字样式 Block
@property (nonatomic, copy) NSAttributedString *(^attributedFormatBlock)(CGFloat);

/// 文本数字变化完成回调 Block
@property (nonatomic, copy) void (^completionBlock)();

/**
 *  文本数字在指定时间内从起始值变化到结束值
 *
 *  @param frame            控件的 frame
 *  @param format           文本数字样式，默认为 @"%f"
 *  @param positiveFormat   文本数字分隔符样式
 *  @param method           文本数字变化方式，默认为 EaseInOut
 *  @param startValue       起始值
 *  @param endValue         结束值
 *  @param duration         变化时间
 *  @param completion       完成回调
 *
 *  @return QCountingLabel 对象
 */
+ (instancetype)q_countingLabelWithFrame:(CGRect)frame
                                  format:(NSString *)format
                          positiveFormat:(nullable NSString *)positiveFormat
                                  method:(QCountingMethod)method
                               fromValue:(CGFloat)startValue
                                 toValue:(CGFloat)endValue
                            withDuration:(NSTimeInterval)duration
                              completion:(void (^)())completion;

/**
 *  文本数字从起始值变化到结束值
 *
 *  <p> 默认变化时间 2.0 秒 <p>
 *
 *  @param startValue   起始值
 *  @param endValue     结束值
 *
 *  @return nil
 */
- (void)q_countFromValue:(CGFloat)startValue toValue:(CGFloat)endValue;

/**
 *  文本数字在指定时间内从起始值变化到结束值
 *
 *  @param startValue   起始值
 *  @param endValue     结束值
 *  @param duration     变化时间
 *
 *  @return nil
 */
- (void)q_countFromValue:(CGFloat)startValue toValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

/**
 *  文本数字从当前值变化到结束值
 *
 *  <p> 默认变化时间 2.0 秒 <p>
 *
 *  @param endValue     结束值
 *
 *  @return nil
 */
- (void)q_countFromCurrentValueToValue:(CGFloat)endValue;

/**
 *  文本数字在指定时间内从当前值变化到结束值
 *
 *  @param endValue     结束值
 *  @param duration     变化时间
 *
 *  @return nil
 */
- (void)q_countFromCurrentValueToValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

/**
 *  文本数字从 0 变化到结束值
 *
 *  <p> 默认变化时间 2.0 秒 <p>
 *
 *  @param endValue     结束值
 *
 *  @return nil
 */
- (void)q_countFromZeroToValue:(CGFloat)endValue;

/**
 *  文本数字在指定时间内从 0 变化到结束值
 *
 *  @param endValue     结束值
 *  @param duration     变化时间
 *
 *  @return nil
 */
- (void)q_countFromZeroToValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration;

@end


NS_ASSUME_NONNULL_END
