//
//  NSString+BundlePath.h
//  QExtension
//
//  Created by JHQ0228 on 16/6/22.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BundlePath)

/**
 *  拼接文档目录
 *
 *  @return 沙盒下的 Documents/"self" 路径
 */
- (NSString *)q_appendDocumentPath;

/**
 *  拼接 MD5 加密的文档目录
 *
 *  @return 沙盒下的 Documents/"self" 路径
 */
- (NSString *)q_appendMD5DocumentPath;

/**
 *  拼接缓存目录
 *
 *  @return 沙盒下的 Library/Caches/"self" 路径
 */
- (NSString *)q_appendCachePath;

/**
 *  拼接 MD5 加密的缓存目录
 *
 *  @return 沙盒下的 Library/Caches/"self" 路径
 */
- (NSString *)q_appendMD5CachePath;

/**
 *  拼接临时目录
 *
 *  @return 沙盒下的 tmp/"self" 路径
 */
- (NSString *)q_appendTempPath;

/**
 *  拼接 MD5 加密的临时目录
 *
 *  @return 沙盒下的 tmp/"self" 路径
 */
- (NSString *)q_appendMD5TempPath;

@end
