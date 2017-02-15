//
//  NSString+Net.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/12.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Net)

/**
 *  获取本地 IP 地址
 *
 *  @return 32 位 IP 地址字符串
 */
+ (NSString *)q_getIPAddress;

/**
 *  由域名获取 IP 地址
 *
 *  @param domain  域名字符串
 *
 *  @return 32 位 IP 地址字符串
 */
+ (NSString *_Nullable)q_getIPWithDomain:(NSString *)domain;

@end


NS_ASSUME_NONNULL_END
