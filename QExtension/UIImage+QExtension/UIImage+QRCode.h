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

#pragma mark - 生成二维码

/**
 *  生成二维码图片
 *
 *  <p> 图片大小默认为 1242 * 1242，头像大小为图片的五分之一 248.4 * 248.4，位置居中 <p>
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

#pragma mark - 识别二维码

/**
 *  识别图片中的二维码
 *
 *  @return 二维码识别结果字符串
 */
- (NSString *)q_stringByRecognizeQRCode NS_AVAILABLE(10_10, 8_0);

#pragma mark - 生成条形码

/**
 *  生成条形码图片
 *
 *  <p> 图片大小默认为 1242 * 414 <p>
 *
 *  @param string       生成条形码的字符串
 *  @param color        二维码的颜色，default is blackColor
 *  @param backColor    二维码的背景颜色，default is whiteColor
 *
 *  @return 生成的条形码图片
 */
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                    color:(nullable UIColor *)color
                                backColor:(nullable UIColor *)backColor NS_AVAILABLE_IOS(8_0);

/**
 *  生成指定大小的条形码图片
 *
 *  @param string       生成条形码的字符串
 *  @param imageSize    生成的条形码图片的大小
 *  @param color        二维码的颜色，default is blackColor
 *  @param backColor    二维码的背景颜色，default is whiteColor
 *
 *  @return 生成的条形码图片
 */
+ (UIImage *)q_imageWithBarCodeFromString:(NSString *)string
                                imageSize:(CGSize)imageSize
                                    color:(nullable UIColor *)color
                                backColor:(nullable UIColor *)backColor NS_AVAILABLE_IOS(8_0);

@end


NS_ASSUME_NONNULL_END
