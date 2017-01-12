//
//  UIImage+QRCode.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (QRCode)

/**
 *  生成二维码图片
 *
 *  @param string       生成二维码的字符串
 *  @param headIcon     二维码中的头像图片
 *  @param color        二维码的颜色，default is blackColor
 *  @param backColor    二维码的背景颜色，default is whiteColor
 *
 *  @return 生成的二维码图片
 */
+ (UIImage *)q_imageWithQRCodeFromString:(NSString *)string
                                headIcon:(nullable UIImage *)headIcon
                                   color:(nullable UIColor *)color
                               backColor:(nullable UIColor *)backColor;

/**
 *  识别图片中的二维码
 *
 *  @return 二维码识别结果字符串
 */
- (NSString *)q_stringByRecognizeQRCode;

@end


NS_ASSUME_NONNULL_END
