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
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(keyWindow.bounds.size, NO, [UIScreen mainScreen].scale);
    // UIGraphicsBeginImageContext(keyWindow.bounds.size);
    
    // 获取图片上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在 context 上渲染
    [keyWindow.layer renderInContext:context];
    
    // 从图片上下文获取当前图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

/// 截取指定视图控件屏幕图
+ (UIImage *)q_imageWithScreenShotFromView:(UIView *)view {
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    // UIGraphicsBeginImageContext(view.bounds.size);
    
    // 获取图片上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 在 context 上渲染
    [view.layer renderInContext:context];
    
    // 从图片上下文获取当前图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

/// 调整图片尺寸
- (UIImage *)q_imageByScalingAndCroppingToSize:(CGSize)size {
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // UIGraphicsBeginImageContext(size);
    
    // 在指定的区域内绘制图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从图片上下文获取当前图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/// 裁剪圆形图片
- (UIImage *)q_imageByCroppingToRound {
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // UIGraphicsBeginImageContext(self.size);
    
    // 设置裁剪路径
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    CGFloat wh = MIN(self.size.width, self.size.height);
    CGRect clipRect = CGRectMake((w - wh) / 2, (h - wh) / 2, wh, wh);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:clipRect];
    
    // 裁剪
    [path addClip];
    
    // 绘制图片
    [self drawAtPoint:CGPointZero];

    // 从图片上下文获取当前图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    
    // 切割图片
    CGRect cutRect = CGRectMake(w - wh, h - wh, wh * 2, wh * 2);
    CGImageRef imageRef = image.CGImage;
    CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, cutRect);
    UIImage *newImage = [[UIImage alloc] initWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return newImage;
}

/// 添加图片水印
- (UIImage *)q_imageWithWaterMarkString:(nullable NSString *)string
                             attributes:(nullable NSDictionary<NSString *, id> *)attrs
                                  image:(nullable UIImage *)image
                                  frame:(CGRect)frame {
    
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // UIGraphicsBeginImageContext(self.size);
    
    // 绘制背景图片
    CGRect backRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:backRect];
    
    CGRect strRect = frame;
    
    // 添加图片水印
    if (image) {
        
        if ((frame.origin.x == -1) && (frame.origin.y == -1)) {
            
            CGFloat w  = frame.size.width;
            CGFloat h = frame.size.height;
            CGFloat x = (backRect.size.width - w) / 2;
            CGFloat y = (backRect.size.height - h) / 2;
            
            [image drawInRect:CGRectMake(x, y, w, h)];
        } else {
            
            [image drawInRect:frame];
            
            strRect = CGRectMake(frame.origin.x + frame.size.width + 5, frame.origin.y, 1, 1);
        }
    }
    
    // 添加文字水印
    if (string) {
        
        if ((frame.origin.x == -1) && (frame.origin.y == -1)) {
    
        } else {
            [string drawAtPoint:strRect.origin withAttributes:attrs];
        }
    }

    // 获取绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end


NS_ASSUME_NONNULL_END
