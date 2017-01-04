//
//  UIImage+GIF.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/5.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

/// 通过名称加载 gif 图片
+ (UIImage *)q_gifImageNamed:(NSString *)name;

/// 通过数据加载 gif 图片
+ (UIImage *)q_gifImageWithData:(NSData *)data;

/// 缩放裁剪图片尺寸到指定大小
- (UIImage *)q_gifImageByScalingAndCroppingToSize:(CGSize)size;

@end
