//
//  NSString+Base64.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+Base64.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (Base64)

/// 对 ASCII 编码的字符串进行 base64 编码
- (NSString *)q_base64Encode {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/// 对 base64 编码的字符串进行解码
- (NSString *)q_base64Decode {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/// 生成服务器基本授权字符串
- (NSString *)q_basic64AuthEncode {
    
    return [@"BASIC " stringByAppendingString:[self q_base64Encode]];
}

@end


NS_ASSUME_NONNULL_END
