//
//  NSString+Language.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/2.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Language)

/**
 *  获取本机现在用的语言
 *
 *      zh-Hans :简体中文
 *      zh-Hant :繁体中文
 *      en      :英文
 *      ja      :日本
 *
 *  @return 本机现在用的语言字符串
 */
+ (NSString *)q_getPreferredLanguage;

@end


NS_ASSUME_NONNULL_END
