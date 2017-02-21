//
//  NSString+BundlePath.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+BundlePath.h"
#import "NSString+Hash.h"
#import <sys/xattr.h>

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (BundlePath)

#pragma mark - 拼接文件路径

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

#pragma mark - 设置文件路径属性

/// 添加文件不备份属性
- (BOOL)q_addSkipBackupAttribute {
    
    const char *filePath = [self fileSystemRepresentation];
    const char *attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

@end


NS_ASSUME_NONNULL_END
