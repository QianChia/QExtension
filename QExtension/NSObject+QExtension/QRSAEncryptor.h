//
//  QRSAEncryptor.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/21.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface QRSAEncryptor : NSObject

/**
 *  使用 .der 公钥证书文件 加密字符串
 *
 *  @param string   需要加密的字符串
 *  @param path     .der 格式的公钥文件路径
 *
 *  @return 经过 RSA 证书加密的字符串
 */
+ (NSString *)q_encryptWithString:(NSString *)string publicKeyFilePath:(NSString *)path;

/**
 *  使用 .p12 私钥证书文件 解密字符串
 *
 *  @param string       需要解密的字符串
 *  @param path         .p12 格式的私钥文件路径
 *  @param password     私钥文件密码
 *
 *  @return 经过 RSA 证书解密的字符串
 */
+ (NSString *)q_decryptWithString:(NSString *)string privateKeyFilePath:(NSString *)path password:(NSString *)password;

/**
 *  使用 公钥字符串 加密字符串
 *
 *  <p> Xcode8+ 需要在 TARGET -> Capabitilies 中开启 Keychain Sharing 开关 <p>
 *
 *  @param string   需要加密的字符串
 *  @param pubKey   公钥字符串，PKCS#8 格式
 *
 *  @return 经过公钥字符串加密的字符串
 */
+ (NSString *)q_encryptWithString:(NSString *)string publicKey:(NSString *)pubKey;

/**
 *  使用 私钥字符串 解密字符串
 *
 *  <p> Xcode8+ 需要在 TARGET -> Capabitilies 中开启 Keychain Sharing 开关 <p>
 *
 *  @param string       需要解密的字符串
 *  @param privateKey   私钥字符串，PKCS#8 格式
 *
 *  @return 经过私钥字符串解密的字符串
 */
+ (NSString *)q_decryptWithString:(NSString *)string privateKey:(NSString *)privateKey;

@end


NS_ASSUME_NONNULL_END
