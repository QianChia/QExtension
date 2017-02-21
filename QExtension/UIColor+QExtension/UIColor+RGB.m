//
//  UIColor+RGB.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/28.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIColor+RGB.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIColor (RGB)

/// 获取 UIColor 的 RGB 值
- (NSArray<NSNumber *> * _Nullable)q_getRGBComponents {
    
    CGColorRef cgColor = self.CGColor;
    size_t numComponents = CGColorGetNumberOfComponents(cgColor);
    
    if (numComponents == 4) {
        
        const CGFloat *components = CGColorGetComponents(cgColor);
        CGFloat R = components[0];
        CGFloat G = components[1];
        CGFloat B = components[2];
        CGFloat alpha = components[3];
        
        return @[@(R), @(G), @(B), @(alpha)];
    }
    return nil;
}

@end


NS_ASSUME_NONNULL_END
