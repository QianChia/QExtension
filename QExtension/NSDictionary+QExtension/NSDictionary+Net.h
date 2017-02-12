//
//  NSDictionary+Net.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/12.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


FOUNDATION_EXPORT NSString * const BSSIDKey;
FOUNDATION_EXPORT NSString * const SSIDKey;
FOUNDATION_EXPORT NSString * const SSIDDATAKey;

@interface NSDictionary (Net)

/**
 *  获取当前 Wifi 信息
 *
 *  @return 当前 Wifi 信息
 */
+ (NSDictionary *)q_getCurrentWifiInfo;

@end


NS_ASSUME_NONNULL_END
