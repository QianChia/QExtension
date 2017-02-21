//
//  NSString+Net.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/12.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+Net.h"
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (Net)

/// 获取本地 IP 地址
+ (NSString *)q_getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0) {
        
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while (temp_addr != NULL) {
            
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/// 由域名获取 IP 地址
+ (NSString * _Nullable)q_getIPWithDomain:(NSString *)domain {
    
    struct sockaddr_in server;
    
    struct hostent *hs = gethostbyname(domain.UTF8String);
    
    if (hs != NULL) {
        
        server.sin_addr = *((struct in_addr *)hs->h_addr_list[0]);
        return [NSString stringWithUTF8String:inet_ntoa(server.sin_addr)];
    }
    return nil;
}

@end


NS_ASSUME_NONNULL_END
