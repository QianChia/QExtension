//
//  NSDictionary+Net.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/12.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSDictionary+Net.h"
#import <SystemConfiguration/CaptiveNetwork.h>

NS_ASSUME_NONNULL_BEGIN


NSString * const BSSIDKey = @"BSSID";
NSString * const SSIDKey = @"SSID";
NSString * const SSIDDATAKey = @"SSIDDATA";

@implementation NSDictionary (Net)

/// 获取当前 Wifi 信息
+ (NSDictionary *)q_getCurrentWifiInfo {
    
    NSDictionary *wifiDic = [NSDictionary dictionary];
    
    CFArrayRef arrayRef = CNCopySupportedInterfaces();
    
    if (arrayRef != nil) {
        
        CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(arrayRef, 0));
        CFRelease(arrayRef);
        
        if (dicRef != nil) {
            
            wifiDic = (NSDictionary *)CFBridgingRelease(dicRef);
        }
    }
    return wifiDic;
}

@end


NS_ASSUME_NONNULL_END
