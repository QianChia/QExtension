//
//  UIColor+Hex.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/19.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIColor+Hex.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIColor (Hex)

/// 由十六进制颜色值创建 RGB 颜色值，带透明度设置
+ (UIColor *)q_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    // r、g、b
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/// 由十六进制颜色值创建 RGB 颜色值
+ (UIColor *)q_colorWithHexString:(NSString *)color {
    
    return [self q_colorWithHexString:color alpha:1.0f];
}

@end


NS_ASSUME_NONNULL_END
