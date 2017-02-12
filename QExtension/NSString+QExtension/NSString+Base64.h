//
//  NSString+Base64.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Base64)

/**
 *  从 iOS 7.0 开始，apple 提供了 base64 的编码解码的支持。
 */

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
- (NSString *)q_base64Encode NS_AVAILABLE(10_9, 7_0);

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
- (NSString *)q_base64Decode NS_AVAILABLE(10_9, 7_0);

/**
 *  生成服务器 base64 编码授权字符串
 *
 *  示例代码格式：
 *  @code
 *  输入字符串为 @"username:password" 格式。
 *  [request setValue:[@"username:password" q_basic64AuthEncode]
 *                          forHTTPHeaderField:@"Authorization"];
 *  @endcode
 *
 *  @return @"BASIC (username:password).base64" 格式的字符串
 */
- (NSString *)q_basic64AuthEncode NS_AVAILABLE(10_9, 7_0);

@end


NS_ASSUME_NONNULL_END
