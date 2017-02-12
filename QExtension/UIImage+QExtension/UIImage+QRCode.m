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

#pragma mark - 生成二维码

/// 生成二维码图片
+ (UIImage *)q_imageWithQRCodeFromString:(NSString *)string
                                headIcon:(nullable UIImage *)headIcon
                                   color:(nullable UIColor *)color
                               backColor:(nullable UIColor *)backColor {
    
    // 默认图片大小 1242 * 1242
    CGSize imageSize = CGSizeMake(1242, 1242);
    
    // 默认头像图片大小 248.4 * 248.4
    CGFloat scale = 5;
    CGFloat width = imageSize.width / scale;
    CGFloat height = imageSize.height / scale;
    CGFloat x = (imageSize.width - width) / 2;
    CGFloat y = (imageSize.height - height) / 2;
    CGRect headFrame = CGRectMake(x, y, width, height);
    
    return [self q_imageWithQRCodeFromString:string
                                   imageSize:imageSize
                                    headIcon:headIcon
                                   headFrame:headFrame
                                       color:color
                                   backColor:backColor];
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

#pragma mark - 识别二维码

/// 识别图片中的二维码
- (NSString *)q_stringByRecognizeQRCode {
    
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    
    // 初始化扫描仪，设置识别类型和识别质量
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    
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

#pragma mark - 生成条形码

/// 生成条形码图片
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                    color:(nullable UIColor *)color
                                backColor:(nullable UIColor *)backColor {
    
    // 默认图片大小 1242 * 414
    CGSize imageSize = CGSizeMake(1242, 414);
    
    return [self q_imageWithBarCodeFromString:string
                                    imageSize:imageSize
                                        color:color
                                    backColor:backColor];
}

/// 生成指定大小的条形码图片
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                imageSize:(CGSize)imageSize
                                    color:(nullable UIColor *)color
                                backColor:(nullable UIColor *)backColor {
    
    UIColor *barColor = color ? : [UIColor blackColor];
    UIColor *barBackColor = backColor ? : [UIColor whiteColor];
    
    // 生成最原始的条形码
    CIFilter *qrFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:contentData forKey:@"inputMessage"];
    [qrFilter setValue:@(0.00) forKey:@"inputQuietSpace"];
    CIImage *ciImage = qrFilter.outputImage;
    
    // 改变条形码尺寸大小
    CGRect integralRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(imageSize.width/CGRectGetWidth(integralRect),
                        imageSize.height/CGRectGetHeight(integralRect));
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil,
                                                   width,
                                                   height,
                                                   8,
                                                   0,
                                                   colorSpaceRef,
                                                   (CGBitmapInfo)kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpaceRef);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    CGImageRelease(bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    // 生成条形码图片
    int imageWidth = image.size.width;
    int imageHeight = imageSize.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpaceRef1 = CGColorSpaceCreateDeviceRGB();
    CGContextRef context1 = CGBitmapContextCreate(rgbImageBuf,
                                                  imageWidth,
                                                  imageHeight,
                                                  8,
                                                  bytesPerRow,
                                                  colorSpaceRef1,
                                                  kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context1, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素, 改变像素点颜色
    CGFloat red = 0.0, green = 0.0, blue = 0.0;
    CGColorRef cgColor = barColor.CGColor;
    size_t numComponents = CGColorGetNumberOfComponents(cgColor);
    
    if (numComponents == 4) {
        const CGFloat *components = CGColorGetComponents(cgColor);
        red = components[0];
        green = components[1];
        blue = components[2];
    }
    
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
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL,
                                                                  rgbImageBuf,
                                                                  bytesPerRow * imageHeight,
                                                                  q_providerReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth,
                                        imageHeight,
                                        8,
                                        32,
                                        bytesPerRow,
                                        colorSpaceRef1,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little,
                                        dataProvider,
                                        NULL,
                                        true,
                                        kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *barImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context1);
    CGColorSpaceRelease(colorSpaceRef1);
    
    CGRect backRect = CGRectMake(0, 0, barImage.size.width, barImage.size.height);
    UIGraphicsBeginImageContext(barImage.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, barBackColor.CGColor);
    CGContextAddRect(ctx, backRect);
    CGContextFillPath(ctx);
    
    [barImage drawInRect:backRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 助手方法

/// 释放内存函数
void q_providerReleaseData(void *info, const void *data, size_t size) {
    free((void*)data);
}

@end


NS_ASSUME_NONNULL_END
