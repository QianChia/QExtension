//
//  UIColor+RGB.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/28.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIColor (RGB)

/**
 *  由 R、G、B 值创建 RGB 颜色值
 *
 *  @param red      红色值，范围 [0 255]
 *  @param green    绿色值，范围 [0 255]
 *  @param blue     蓝色值，范围 [0 255]
 *
 *  @return RGB 颜色值
 */
+ (UIColor *)q_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/**
 *  由 R、G、B 值创建 RGB 颜色值
 *
 *  @param red      红色值，范围 [0 255]
 *  @param green    绿色值，范围 [0 255]
 *  @param blue     蓝色值，范围 [0 255]
 *  @param alpha    透明度，范围 [0 1]
 *
 *  @return RGB 颜色值
 */
+ (UIColor *)q_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 *  获取 UIColor 的 RGB 值
 *
 *  @return R、G、B 值
 */
- (NSArray<NSNumber *> * _Nullable)q_getRGBComponents;

@end


NS_ASSUME_NONNULL_END
