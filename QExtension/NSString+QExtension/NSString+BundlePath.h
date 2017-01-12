//
//  NSString+BundlePath.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (BundlePath)

/**
 *  拼接文档目录
 *
 *  @return 沙盒下的 Documents/"self.lastPathComponent" 路径
 */
- (NSString *)q_appendDocumentPath;

/**
 *  拼接 MD5 加密的文档目录
 *
 *  @return 沙盒下的 Documents/"self.md5" 路径
 */
- (NSString *)q_appendMD5DocumentPath;

/**
 *  拼接缓存目录
 *
 *  @return 沙盒下的 Library/Caches/"self.lastPathComponent" 路径
 */
- (NSString *)q_appendCachePath;

/**
 *  拼接 MD5 加密的缓存目录
 *
 *  @return 沙盒下的 Library/Caches/"self.md5" 路径
 */
- (NSString *)q_appendMD5CachePath;

/**
 *  拼接临时目录
 *
 *  @return 沙盒下的 tmp/"self.lastPathComponent" 路径
 */
- (NSString *)q_appendTempPath;

/**
 *  拼接 MD5 加密的临时目录
 *
 *  @return 沙盒下的 tmp/"self.md5" 路径
 */
- (NSString *)q_appendMD5TempPath;

@end


NS_ASSUME_NONNULL_END
