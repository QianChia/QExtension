//
//  UIImage+QRCode.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIImage+QRCode.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIImage (QRCode)

/// 生成二维码图片
+ (UIImage *)q_imageWithQRCodeFromString:(NSString *)string
                                headIcon:(nullable UIImage *)headIcon
                                   color:(nullable UIColor *)color
                               backColor:(nullable UIColor *)backColor {
    
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复默认
    [filter setDefaults];
    
    // 给过滤器添加数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过 KVO 设置滤镜 inputMessage 数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 设置二维码颜色
    UIColor *onColor = color ? : [UIColor blackColor];
    UIColor *offColor = backColor ? : [UIColor whiteColor];
    
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:@"inputImage", filter.outputImage,
                                                     @"inputColor0", [CIColor colorWithCGColor:onColor.CGColor],
                                                     @"inputColor1", [CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    // 获取输出的二维码
    CIImage *outputImage = colorFilter.outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    // 将 CIImage 转换成 UIImage，并放大显示
    UIImage *qrImage = [UIImage imageWithCGImage:cgImage
                                           scale:1.0
                                     orientation:UIImageOrientationUp];
    CGImageRelease(cgImage);
    
    // 重绘二维码图片，默认情况下生成的图片比较模糊
    
    CGFloat scale = 100;
    CGFloat width = qrImage.size.width * scale;
    CGFloat height = qrImage.size.height * scale;
    CGRect backRect = CGRectMake(0, 0, width, height);
    
    UIGraphicsBeginImageContext(backRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    [qrImage drawInRect:backRect];
    qrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 添加头像
    if (headIcon != nil) {
        
        UIGraphicsBeginImageContext(qrImage.size);
        [qrImage drawInRect:backRect];
        
        CGFloat scale = 5;
        CGFloat width = qrImage.size.width / scale;
        CGFloat height = qrImage.size.height / scale;
        CGFloat x = (qrImage.size.width - width) / 2;
        CGFloat y = (qrImage.size.height - height) / 2;
        CGRect headRect = CGRectMake(x, y, width, height);
        
        // 绘制头像
        [headIcon drawInRect:headRect];
        
        // 获取添加头像后的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return newImage;
    } else {
        return qrImage;
    }
}

/// 识别图片中的二维码
- (NSString *)q_stringByRecognizeQRCode {
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    
    // 初始化扫描仪，设置识别类型和识别质量
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 扫描获取的特征组
    NSArray *features = [detector featuresInImage:ciImage];
    
    if (features.count >= 1) {
        
        // 获取扫描结果
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *resultString = feature.messageString;
        
        return resultString;
        
    } else {
        return @"该图片中不包含二维码";
    }
}

@end


NS_ASSUME_NONNULL_END