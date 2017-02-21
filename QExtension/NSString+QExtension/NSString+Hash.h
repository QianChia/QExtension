//
//  NSString+Hash.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Hash)

#pragma mark - 散列函数

/**
 *  计算 MD5 散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32 个字符的 MD5 散列字符串
 */
- (NSString *)q_md5String;

/**
 *  计算 SHA1 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40 个字符的 SHA1 散列字符串
 */
- (NSString *)q_sha1String;

/**
 *  计算 SHA224 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha224
 *  @endcode
 *
 *  @return 56 个字符的 SHA224 散列字符串
 */
- (NSString *)q_sha224String;

/**
 *  计算 SHA256 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64 个字符的 SHA256 散列字符串
 */
- (NSString *)q_sha256String;

/**
 *  计算 SHA384 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha384
 *  @endcode
 *
 *  @return 96 个字符的 SHA384 散列字符串
 */
- (NSString *)q_sha384String;

/**
 *  计算 SHA512 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128 个字符的 SHA512 散列字符串
 */
- (NSString *)q_sha512String;

#pragma mark - HMAC 散列函数

/**
 *  计算 HMAC MD5 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32 个字符的 HMAC MD5 散列字符串
 */
- (NSString *)q_hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算 HMAC SHA1 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40 个字符的 HMAC SHA1 散列字符串
 */
- (NSString *)q_hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算 HMAC SHA224 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha224 -hmac "key"
 *  @endcode
 *
 *  @return 56 个字符的 HMAC SHA224 散列字符串
 */
- (NSString *)q_hmacSHA224StringWithKey:(NSString *)key;

/**
 *  计算 HMAC SHA256 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64 个字符的 HMAC SHA256 散列字符串
 */
- (NSString *)q_hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算 HMAC SHA384 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha384 -hmac "key"
 *  @endcode
 *
 *  @return 96 个字符的 HMAC SHA384 散列字符串
 */
- (NSString *)q_hmacSHA384StringWithKey:(NSString *)key;

/**
 *  计算 HMAC SHA512 散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128 个字符的 HMAC SHA512 散列字符串
 */
- (NSString *)q_hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 时间戳散列函数

/**
 *  计算时间戳的 HMAC 散列结果
 *
 *  <p>提示：同样的密码，同样的加密算法，每分钟加密的结果都不一样。<p>
 *
 *  @param key 秘钥
 *
 *  @return 32 个字符的 HMAC 散列字符串
 */
- (NSString *)q_timeMD5StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数

/**
 *  计算文件的 MD5 散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32 个字符的 MD5 散列字符串
 */
- (NSString * __nullable)q_fileMD5Hash;

/**
 *  计算文件的 SHA1 散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40 个字符的 SHA1 散列字符串
 */
- (NSString * __nullable)q_fileSHA1Hash;

/**
 *  计算文件的 SHA256 散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64 个字符的 SHA256 散列字符串
 */
- (NSString * __nullable)q_fileSHA256Hash;

/**
 *  计算文件的 SHA512 散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128 个字符的 SHA512 散列字符串
 */
- (NSString * __nullable)q_fileSHA512Hash;

@end


NS_ASSUME_NONNULL_END
