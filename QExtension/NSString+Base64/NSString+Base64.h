//
//  NSString+Base64.h
//  QExtension
//
//  Created by JHQ0228 on 16/7/4.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  对 ASCII 编码的字符串进行 base64 编码
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | base64
 *  base64 fileName1 -o fileName2
 *  @endcode
 *
 *  @return base64 编码的字符串
 */
- (NSString *)q_base64Encode;

/**
 *  对 base64 编码的字符串进行解码
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | base64 -D
 *  base64 fileName2 -o fileName1 -D
 *  @endcode
 *
 *  @return ASCII 编码的字符串
 */
- (NSString *)q_base64Decode;

/**
 *  生成服务器 base64 编码授权字符串
 *
 *  示例代码格式：
 *  @code
 *  [request setValue:[@"username:password" q_basic64AuthEncode] forHTTPHeaderField:@"Authorization"];
 *  @endcode
 *
 *  @return @"BASIC (username:password).base64" 格式的字符串
 */
- (NSString *)q_basic64AuthEncode;

@end
