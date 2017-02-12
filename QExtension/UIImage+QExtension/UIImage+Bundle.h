//
//  UIImage+Bundle.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/28.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (Bundle)

/**
 *  从 Bundle 文件中加载图片
 *
 *  @param name         图片名称
 *  @param bundleName   Bundle 文件名称
 *
 *  <p> #define BUNDLE_IMAGE(name)  [UIImage q_imageNamed:(name) fromBundle:@"DemoBundle"] <p>
 *
 *  @return 加载的图片
 */
+ (UIImage *)q_imageNamed:(NSString *)name fromBundle:(NSString *)bundleName;

@end


NS_ASSUME_NONNULL_END
