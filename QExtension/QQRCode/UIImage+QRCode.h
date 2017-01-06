//
//  UIImage+QRCode.h
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/6.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (QRCode)

/**
 *  识别二维码
 *
 *  @return 识别结果字符串
 */
- (NSString *)q_recognizeQRCode;

/**
 *  生成二维码
 *
 *  @param inputStr     生成二维码的字符串
 *  @param headIcon     二维码中的头像图片
 *  @param color        二维码的颜色
 *  @param backColor    二维码的背景颜色
 *
 *  @return 拼接的待上传文件的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (UIImage *)q_createQRCodeFromString:(NSString *)inputStr
                             headIcon:(nullable UIImage *)headIcon
                                color:(nullable UIColor *)color
                            backColor:(nullable UIColor *)backColor;

@end


NS_ASSUME_NONNULL_END
