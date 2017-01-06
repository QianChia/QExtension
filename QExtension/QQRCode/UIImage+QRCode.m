//
//  UIImage+QRCode.m
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/6.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIImage+QRCode.h"

NS_ASSUME_NONNULL_BEGIN


@implementation UIImage (QRCode)

#pragma mark - 识别二维码

/// 识别二维码
- (NSString *)q_recognizeQRCode {
    
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

#pragma mark - 生成二维码

/// 生成二维码
+ (UIImage *)q_createQRCodeFromString:(NSString *)inputStr
                             headIcon:(nullable UIImage *)headIcon
                                color:(nullable UIColor *)color
                            backColor:(nullable UIColor *)backColor {
    
    // 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复默认
    [filter setDefaults];
    
    // 给过滤器添加数据
    NSData *data = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    
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
    // CIImage *outputImage = [filter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    
    // 将 CIImage 转换成 UIImage，并放大显示
    UIImage *qrImage = [UIImage imageWithCGImage:cgImage
                                           scale:1.0
                                     orientation:UIImageOrientationUp];
    
    // 重绘 UIImage，默认情况下生成的图片比较模糊
    CGFloat scale = 100;
    CGFloat width = qrImage.size.width * scale;
    CGFloat height = qrImage.size.height * scale;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context1, kCGInterpolationNone);
    [qrImage drawInRect:CGRectMake(0, 0, width, height)];
    qrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    // 添加头像
    if (headIcon != nil) {
        
        UIGraphicsBeginImageContext(qrImage.size);
        [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
        
        // 设置头像的大小
        CGFloat scale = 5;
        CGFloat width = qrImage.size.width / scale;
        CGFloat height = qrImage.size.height / scale;
        CGFloat x = (qrImage.size.width - width) / 2;
        CGFloat y = (qrImage.size.height - height) / 2;
        [headIcon drawInRect:CGRectMake( x,  y, width, height)];
        
        UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
        
    } else {
        return qrImage;
    }
}

@end


NS_ASSUME_NONNULL_END
