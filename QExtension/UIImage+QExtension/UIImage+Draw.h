//
//  UIImage+Draw.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (Draw)

/**
 *  截取全屏幕图
 *
 *  @return 截取的全屏图片
 */
+ (UIImage *)q_imageWithScreenShot;

/**
 *  截取指定视图控件屏幕图
 *
 *  @param view    需要截屏的视图控件
 *
 *  @return 截取视图控件图片
 */
+ (UIImage *)q_imageWithScreenShotFromView:(UIView *)view;

/**
 *  调整图片尺寸
 *
 *  @param size     指定的图片大小
 *
 *  @return 调整大小的图片
 */
- (UIImage *)q_imageByScalingAndCroppingToSize:(CGSize)size;

/**
 *  裁剪圆形图片
 *
 *  @return 裁剪好的圆形图片
 */
- (UIImage *)q_imageByCroppingToRound;

/**
 *  添加图片水印
 *
 *  @param string   添加到水印中的文本内容
 *  @param attrs    水印文字的属性
 *  @param image    添加到水印中的图片
 *  @param frame    水印的位置尺寸
 *
 *  @return 添加水印的图片
 */
- (UIImage *)q_imageWithWaterMarkString:(nullable NSString *)string
                             attributes:(nullable NSDictionary<NSString *, id> *)attrs
                                  image:(nullable UIImage *)image
                                  frame:(CGRect)frame;

@end


NS_ASSUME_NONNULL_END
