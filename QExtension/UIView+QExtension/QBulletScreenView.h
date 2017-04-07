//
//  QBulletScreenView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/21.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QBulletScreenViewDelegate

/// 弹幕内容点击处理协议
@protocol QBulletScreenViewDelegate <NSObject>

- (void)didClickContentAtIndex:(NSInteger)index;

@end


#pragma mark - QBulletScreenView

/// 弹幕滚动方向枚举
typedef NS_ENUM(NSUInteger, QBulletScreenViewDirection) {
    QBulletScreenViewDirectionUp,
    QBulletScreenViewDirectionDown,
    QBulletScreenViewDirectionLeft,
    QBulletScreenViewDirectionRight
};

@interface QBulletScreenView : UIView

/// 显示的文本内容
@property (nonatomic, strong) IBInspectable NSArray *contentTexts;

/// 显示的文本内容颜色，default is redColor
@property (nonatomic, strong) IBInspectable UIColor *contentTextColor;

/// 显示的文本内容字体，default is 15.0
@property (nonatomic, strong) IBInspectable UIFont *contentTextFont;

/// 显示的图标内容，可以为 nil 不显示图标
@property (nonatomic, strong) IBInspectable UIImage *contentIcon;

/// 动画方向，default is QBulletScreenViewDirectionLeft
@property (nonatomic, assign) IBInspectable QBulletScreenViewDirection animationDirection;

/// 动画时间，等于 0 时不滚动
@property (nonatomic, assign) IBInspectable NSTimeInterval animationDuration;

/// 代理
@property (nonatomic, weak) IBInspectable id<QBulletScreenViewDelegate> delegate;

/**
 *  开始动画
 */
- (void)q_startAnimation;

/**
 *  创建弹幕视图控件
 *
 *  @param frame        跑马灯对象的 frame
 *  @param texts        显示的文本内容
 *  @param color        显示的文本内容颜色，default is redColor
 *  @param font         显示的文本内容字体，default is 15.0
 *  @param icon         显示的图片内容
 *  @param direction    动画方向，default is QMarqueeViewDirectionUp
 *  @param duration     动画时间，等于 0 时不滚动
 *  @param target       代理
 *
 *  @return 弹幕视图控件
 */
+ (instancetype)q_bulletScreenWithFrame:(CGRect)frame
                                  texts:(NSArray *)texts
                                  color:(nullable UIColor *)color
                                   font:(nullable UIFont *)font
                                   icon:(nullable UIImage *)icon
                              direction:(QBulletScreenViewDirection)direction
                               duration:(NSTimeInterval)duartion
                                 target:(nullable id<QBulletScreenViewDelegate>)target;

@end


NS_ASSUME_NONNULL_END
