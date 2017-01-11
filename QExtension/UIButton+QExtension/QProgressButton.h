//
//  QProgressButton.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QProgressButton : UIButton

/**
 *  创建带进度条的按钮
 *
 *  @param progress         进度值，范围 0 ～ 1.0
 *  @param lineWidth        进度条的线宽
 *  @param lineColor        进度条线的颜色
 *  @param backgroundColor  按钮的背景颜色
 *
 *  @return 带进度条的按钮
 */
+ (instancetype)q_progressButtonWithFrame:(CGRect)frame
                                 progress:(CGFloat)progress
                                lineWidth:(CGFloat)lineWidth
                                lineColor:(nullable UIColor *)lineColor
                          backgroundColor:(nullable UIColor *)backgroundColor;

@end


NS_ASSUME_NONNULL_END
