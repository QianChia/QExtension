//
//  QPaintBoardView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/15.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QPaintBoardView : UIView

/// 画线的宽度，default is 1，max is 30
@property (nonatomic, assign) IBInspectable CGFloat paintLineWidth;

/// 画笔的颜色，default is blackColor
@property (nonatomic, strong) IBInspectable UIColor *paintLineColor;

/// 画板的颜色，default is whiteColor
@property (nonatomic, strong) IBInspectable UIColor *paintBoardColor;

/**
 *  创建画板视图控件，获取绘画结果
 *
 *  @param frame        画板视图控件 frame
 *  @param lineWidth    画笔的线宽，default is 1，max is 30
 *  @param lineColor    画笔的颜色，default is blackColor
 *  @param boardColor   画板的颜色，default is whiteColor
 *  @param result       绘画结果
 *
 *  @return 手势锁视图控件
 */
+ (instancetype)q_paintBoardViewWithFrame:(CGRect)frame
                                lineWidth:(CGFloat)lineWidth
                                lineColor:(nullable UIColor *)lineColor
                               boardColor:(nullable UIColor *)boardColor
                              paintResult:(void (^)(UIImage * _Nullable image))result;

/**
 *  创建简单画板视图控件
 *
 *  @param frame    画板视图控件 frame
 *
 *  @return 手势锁视图控件
 */
+ (instancetype)q_paintBoardViewWithFrame:(CGRect)frame;

/**
 *  获取绘画结果
 *
 *  @return 绘画结果图片
 */
- (UIImage * _Nullable)q_getPaintImage;

/**
 *  清除绘画结果
 */
- (void)q_clear;

/**
 *  撤销绘画结果
 */
- (void)q_back;

@end


NS_ASSUME_NONNULL_END
