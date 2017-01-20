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

@protocol QMarqueeViewDelegate <NSObject>

- (void)didClickContentAtIndex:(NSInteger)index;

@end


#pragma mark - QMarqueeView

/// 跑马灯滚动方向
typedef NS_ENUM(NSUInteger, QMarqueeViewDirection) {
    
    QMarqueeViewDirectionUp,
    QMarqueeViewDirectionDown,
    QMarqueeViewDirectionLeft,
    QMarqueeViewDirectionRight
};

@interface QMarqueeView : UIView

/// 显示的文本内容
@property (nonatomic, strong) NSArray *contentTexts;

/// 显示的文本内容颜色，default is redColor
@property (nonatomic, strong) UIColor *contentTextColor;

/// 显示的文本内容字体，default is 15.0
@property (nonatomic, strong) UIFont *contentTextFont;

/// 显示的文本内容对齐方式，default is NSTextAlignmentLeft
@property (nonatomic, assign) NSTextAlignment contentTextAlign;

/// 显示的图片内容
@property (nonatomic, strong) UIImage *contentImage;

/// 滚动方向，default is QMarqueeViewDirectionUp
@property (nonatomic, assign) QMarqueeViewDirection animationDirection;

/// 动画时间，等于 0 时不滚动
@property (nonatomic, assign) NSTimeInterval animationDuration;

/// 两个动画之间的时间间隔，default is 1.0 秒
@property (nonatomic, assign) NSTimeInterval animationDelay;

/// 水平滚动时两个字符串之间的间隔，default is 20
@property (nonatomic, assign) CGFloat horizontalSpace;

/// 代理
@property (nonatomic, weak) id<QMarqueeViewDelegate> delegate;

/**
 *  开始滚动
 */
- (void)q_startAnimation;

/**
 *  创建跑马灯对象，开始滚动
 *
 *  @param frame        跑马灯对象的 frame
 *  @param texts        显示的文本内容
 *  @param color        显示的文本内容颜色
 *  @param font         变化时间
 *  @param image        显示的文本内容字体
 *  @param duration     动画时间
 *  @param align        显示的文本内容对齐方式
 *  @param target       代理
 *
 *  @return 跑马灯对象
 */
+ (instancetype)q_marqueeViewWithFrame:(CGRect)frame
                                 texts:(NSArray *)texts
                                 color:(nullable UIColor *)color
                                  font:(nullable UIFont *)font
                                 image:(nullable UIImage *)image
                              duration:(NSTimeInterval)duartion
                             direction:(QMarqueeViewDirection)direction
                                 align:(NSTextAlignment)align
                                target:(id<QMarqueeViewDelegate>)target;

@end


NS_ASSUME_NONNULL_END
