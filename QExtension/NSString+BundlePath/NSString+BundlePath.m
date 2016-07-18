//
//  NSString+BundlePath.m
//  QExtension
//
//  Created by JHQ0228 on 16/6/22.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "NSString+BundlePath.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (BundlePath)

/// 拼接文档目录

- (NSString *)q_appendDocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5DocumentPath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:[self q_md5String]];
}

///  拼接缓存目录

- (NSString *)q_appendCachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5CachePath {
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    return [dir stringByAppendingPathComponent:[self q_md5String]];
}

/// 拼接临时目录

- (NSString *)q_appendTempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)q_appendMD5TempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self q_md5String]];
}

/**
 *  计算 MD5 散列结果
 *
 *  @return 32 个字符的 MD5 散列字符串
 */
- (NSString *)q_md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self q_stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)q_stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

@end
