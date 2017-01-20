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
    
    CGFloat width = 1242;
    CGFloat height = 1242;
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
        CGFloat width = backRect.size.width / scale;
        CGFloat height = backRect.size.height / scale;
        CGFloat x = (backRect.size.width - width) / 2;
        CGFloat y = (backRect.size.height - height) / 2;
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

/// 生成指定大小的二维码图片
+ (UIImage *)q_imageWithQRCodeFromString:(NSString *)string
                               imageSize:(CGSize)imageSize
                                headIcon:(nullable UIImage *)headIcon
                               headFrame:(CGRect)headFrame
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
    
    CGRect backRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContext(backRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    [qrImage drawInRect:backRect];
    qrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 添加头像
    if (headIcon != nil) {
        
        UIGraphicsBeginImageContext(backRect.size);
        [qrImage drawInRect:backRect];
        
        // 绘制头像
        [headIcon drawInRect:headFrame];
        
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

/// 生成条形码图片
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                imageSize:(CGSize)imageSize
                                      red:(CGFloat)red
                                    green:(CGFloat)green
                                     blue:(CGFloat)blue {

    // 生成最原始的条形码
    CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@(0.00) forKey:@"inputQuietSpace"];
    CIImage *ciImage = qrFilter.outputImage;
    
    // 改变条形码尺寸大小
    CGRect integralRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(imageSize.width/CGRectGetWidth(integralRect), imageSize.height/CGRectGetHeight(integralRect));
    
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    
    // 生成条形码图片
    int imageWidth = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef1 = CGColorSpaceCreateDeviceRGB();
    CGContextRef context1 = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef1,
                                                 kCGBitmapByteOrder32Little|kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context1, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素, 改变像素点颜色
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = red * 255;
            ptr[2] = green * 255;
            ptr[1] = blue * 255;
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 取出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, q_providerReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef1,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context1);
    CGColorSpaceRelease(colorSpaceRef1);
    
    return resultImage;
}

void q_providerReleaseData(void *info, const void *data, size_t size) {
    free((void*)data);
}

@end


NS_ASSUME_NONNULL_END
