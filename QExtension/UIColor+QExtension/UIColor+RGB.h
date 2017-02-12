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
 *  获取 UIColor 的 RGB 值
 *
 *  @return R、G、B 值
 */
- (NSArray<NSNumber *> *)q_getRGBComponents;

@end


NS_ASSUME_NONNULL_END
