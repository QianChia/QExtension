//
//  UIColor+Hex.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/19.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIColor (Hex)

/**
 *  由十六进制颜色值创建 RGB 颜色值
 *
 *  <p> 适用于 0Xc83c23、#c83c23、c83c23 格式的十六进制颜色值<p>
 *
 *  @param color    十六进制的颜色值字符串
 *
 *  @return RGB 颜色值
 */
+ (UIColor *)q_colorWithHexString:(NSString *)color;

/**
 *  由十六进制颜色值创建 RGB 颜色值
 *
 *  <p> 适用于 0Xc83c23、#c83c23、c83c23 格式的十六进制颜色值<p>
 *
 *  @param color    十六进制的颜色值字符串
 *  @param alpha    透明度，范围 0 ～ 1
 *
 *  @return RGB 颜色值
 */
+ (UIColor *)q_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end


NS_ASSUME_NONNULL_END
