//
//  UIImage+Draw.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIImage+Draw.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIImage (Draw)

/// 截取全屏幕图
+ (UIImage *)q_imageWithScreenShot {
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 获取图形上下文
    UIGraphicsBeginImageContextWithOptions(keyWindow.bounds.size, NO, [UIScreen mainScreen].scale);
    // UIGraphicsBeginImageContext(keyWindow.bounds.size);
    
    // 获取视图控件上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在 context 上渲染
    [keyWindow.layer renderInContext:context];
    
    // 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

/// 截取指定视图控件屏幕图
+ (UIImage *)q_imageWithScreenShotFromView:(UIView *)view {
    
    // 获取图形上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    // UIGraphicsBeginImageContext(view.bounds.size);
    
    // 获取视图控件上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在 context 上渲染
    [view.layer renderInContext:context];
    
    // 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

/// 调整图片尺寸
- (UIImage *)q_imageByScalingAndCroppingToSize:(CGSize)size {
    
    // 获取图形上下文
    UIGraphicsBeginImageContext(size);
    
    // 在指定的尺寸内绘制图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/// 裁剪圆形图片
- (UIImage *)q_imageByCroppingToRound {
    
    // size  ：画板（上下文）尺寸
    // opaque：是否透明，NO 不透明 显示视图控件的背景色，YES 显示黑色
    // scale ：缩放，如果不缩放，设置为 0
    
    // 获取图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // UIGraphicsBeginImageContext(image.size);
    
    // 描述圆形的路径
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    // 把圆形路径设置裁剪区域
    [path addClip];
    
    // 绘制（裁剪）图片，先设置裁剪区域，再裁剪，才会有效
    [self drawAtPoint:CGPointZero];
    
    // 获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end


NS_ASSUME_NONNULL_END
