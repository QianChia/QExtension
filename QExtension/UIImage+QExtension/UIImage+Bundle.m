//
//  UIImage+Bundle.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/28.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIImage+Bundle.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIImage (Bundle)

/// 从 Bundle 文件中加载图片
+ (UIImage *)q_imageNamed:(NSString *)name fromBundle:(NSString *)bundleName {
    
    NSMutableString *bundleN = [NSMutableString stringWithString:bundleName];
    
    if ([bundleName hasSuffix:@".bundle"] == NO) {
        [bundleN appendString:@".bundle"];
    }
    
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleN];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:name];
    
    return [UIImage imageWithContentsOfFile:filePath];
}

@end


NS_ASSUME_NONNULL_END
