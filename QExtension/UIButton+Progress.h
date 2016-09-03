//
//  UIButton+Progress.h
//  QExtension
//
//  Created by JHQ0228 on 16/7/12.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Progress)

/**
 *  设置按钮的进度条
 *
 *  按钮必须为 Custom 类型
 *
 *  @param progress         进度值，范围 0 ～ 1.0
 *  @param lineWidth        进度条的线宽
 *  @param lineColor        进度条线的颜色
 *  @param backgroundColor  按钮的背景颜色
 *
 *  @return 带进度条的按钮
 */
- (void)q_setButtonWithProgress:(float)progress
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(nullable UIColor *)lineColor
                backgroundColor:(nullable UIColor *)backgroundColor;

@end


NS_ASSUME_NONNULL_END
