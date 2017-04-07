//
//  QMarqueeView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/20.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QMarqueeViewDelegate

/// 跑马灯内容点击处理协议
@protocol QMarqueeViewDelegate <NSObject>

- (void)didClickContentAtIndex:(NSInteger)index;

@end


#pragma mark - QMarqueeView

/// 跑马灯滚动方向枚举
typedef NS_ENUM(NSUInteger, QMarqueeViewDirection) {
    QMarqueeViewDirectionUp,
    QMarqueeViewDirectionDown,
    QMarqueeViewDirectionLeft,
    QMarqueeViewDirectionRight
};

@interface QMarqueeView : UIView

/// 显示的文本内容
@property (nonatomic, strong) IBInspectable NSArray *contentTexts;

/// 显示的文本内容颜色，default is redColor
@property (nonatomic, strong) IBInspectable UIColor *contentTextColor;

/// 显示的文本内容字体，default is 15.0
@property (nonatomic, strong) IBInspectable UIFont *contentTextFont;

/// 显示的文本内容对齐方式，default is NSTextAlignmentLeft
@property (nonatomic, assign) IBInspectable NSTextAlignment contentTextAlign;

/// 显示的图标内容，可以为 nil 不显示图标
@property (nonatomic, strong) IBInspectable UIImage *contentIcon;

/// 动画方向，default is QMarqueeViewDirectionUp
@property (nonatomic, assign) IBInspectable QMarqueeViewDirection animationDirection;

/// 动画时间，等于 0 时不滚动
@property (nonatomic, assign) IBInspectable NSTimeInterval animationDuration;

/// 动画停顿时间，default is 1.0 秒
@property (nonatomic, assign) IBInspectable NSTimeInterval animationDelay;

/// 代理
@property (nonatomic, weak) IBInspectable id<QMarqueeViewDelegate> delegate;

/**
 *  开始动画
 */
- (void)q_startAnimation;

/**
 *  创建跑马灯视图控件，开始滚动
 *
 *  @param frame        跑马灯对象的 frame
 *  @param texts        显示的文本内容
 *  @param color        显示的文本内容颜色，default is redColor
 *  @param font         显示的文本内容字体，default is 15.0
 *  @param align        显示的文本内容对齐方式，default is NSTextAlignmentLeft
 *  @param icon         显示的图片内容
 *  @param direction    动画方向，default is QMarqueeViewDirectionUp
 *  @param duration     动画时间，等于 0 时不滚动
 *  @param delay        动画停顿时间，default is 1.0 秒
 *  @param target       代理
 *
 *  @return 跑马灯视图控件
 */
+ (instancetype)q_marqueeViewWithFrame:(CGRect)frame
                                 texts:(NSArray *)texts
                                 color:(nullable UIColor *)color
                                  font:(nullable UIFont *)font
                                 align:(NSTextAlignment)align
                                  icon:(nullable UIImage *)icon
                             direction:(QMarqueeViewDirection)direction
                              duration:(NSTimeInterval)duartion
                                 delay:(NSTimeInterval)delay
                                target:(nullable id<QMarqueeViewDelegate>)target;

@end


NS_ASSUME_NONNULL_END
