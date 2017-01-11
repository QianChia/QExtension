//
//  NSString+BundlePath.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+BundlePath.h"
#import "NSString+Hash.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (BundlePath)

/// 拼接文档目录

- (NSString *)q_appendDocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask,
                                                        YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5DocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask,
                                                        YES).lastObject;
    return [dir stringByAppendingPathComponent:[self q_md5String]];
}

/// 拼接缓存目录

- (NSString *)q_appendCachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                        NSUserDomainMask,
                                                        YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5CachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                        NSUserDomainMask,
                                                        YES).lastObject;
    return [dir stringByAppendingPathComponent:[self q_md5String]];
}

/// 拼接临时目录

- (NSString *)q_appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5TempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self q_md5String]];
}

@end


NS_ASSUME_NONNULL_END
