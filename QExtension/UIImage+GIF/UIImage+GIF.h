//
//  UIImage+GIF.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/5.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (GIF)

/**
 *  通过名称加载 gif 图片
 *
 *  @param name     图片名称，不需要写扩展名
 *
 *  @return 加载的 gif 动图
 */
+ (UIImage *)q_gifImageNamed:(NSString *)name;

/**
 *  通过数据加载 gif 图片
 *
 *  @param data     图片数据
 *
 *  @return 加载的 gif 动图
 */
+ (UIImage *)q_gifImageWithData:(NSData *)data;

/**
 *  缩放裁剪图片尺寸到指定大小
 *
 *  @param size     指定的图片大小
 *
 *  @return 加载的 gif 动图
 */
- (UIImage *)q_gifImageByScalingAndCroppingToSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END
