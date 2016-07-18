//
//  NSString+Base64.m
//  QExtension
//
//  Created by JHQ0228 on 16/7/4.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)

/* 
 从 iOS 7.0 开始，apple 提供了 base64 的编码解码的支持。
 */

/**
 *  对 ASCII 编码的字符串进行 base64 编码
 *
 *  <p>提示：self 为 ASCII 编码的字符串。<p>
 *
 *  @return base64 编码的字符串
 */
- (NSString *)q_base64Encode {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];               
    
    return [data base64EncodedStringWithOptions:0];
}

/**
 *  对 base64 编码的字符串进行解码
 *
 *  <p>提示：self 为 base64 编码的字符串。<p>
 *
 *  @return ASCII 编码的字符串
 */
- (NSString *)q_base64Decode {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 *  生成服务器基本授权字符串
 *
 *  <p>提示：self 为 @"username:password" 格式的字符串。<p>
 *
 *  @return @"BASIC (username:password).base64" 格式的字符串
 */
- (NSString *)q_basic64AuthEncode {
    
    return [@"BASIC " stringByAppendingString:[self q_base64Encode]];
}

@end
