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

@end


NS_ASSUME_NONNULL_END
