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
                               backColor:(nullable UIColor *)backColor NS_AVAILABLE_IOS(7_0);

/**
 *  生成指定大小的二维码图片
 *
 *  @param string       生成二维码的字符串
 *  @param imageSize    生成的二维码图片的大小
 *  @param headIcon     二维码中的头像图片
 *  @param headFrame    二维码中头像图片的位置大小
 *  @param color        二维码的颜色，default is blackColor
 *  @param backColor    二维码的背景颜色，default is whiteColor
 *
 *  @return 生成的二维码图片
 */
+ (UIImage *)q_imageWithQRCodeFromString:(NSString *)string
                               imageSize:(CGSize)imageSize
                                headIcon:(nullable UIImage *)headIcon
                               headFrame:(CGRect)headFrame
                                   color:(nullable UIColor *)color
                               backColor:(nullable UIColor *)backColor NS_AVAILABLE_IOS(7_0);

/**
 *  识别图片中的二维码
 *
 *  @return 二维码识别结果字符串
 */
- (NSString *)q_stringByRecognizeQRCode NS_AVAILABLE_IOS(7_0);

/**
 *  生成指定大小的条形码图片
 *
 *  @param string       生成条形码的字符串
 *  @param imageSize    生成的条形码图片的大小
 *  @param red          红色基值，范围 0 ~ 1
 *  @param green        绿色基值，范围 0 ~ 1
 *  @param blue         蓝色基值，范围 0 ~ 1
 *
 *  @return 生成的条形码图片
 */
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                imageSize:(CGSize)imageSize
                                      red:(CGFloat)red
                                    green:(CGFloat)green
                                     blue:(CGFloat)blue NS_AVAILABLE_IOS(8_0);

@end


NS_ASSUME_NONNULL_END
