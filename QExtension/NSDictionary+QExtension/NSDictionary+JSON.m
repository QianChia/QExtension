//
//  NSDictionary+JSON.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSDictionary+JSON.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSDictionary (JSON)

/// JSON 字符串转换成字典
+ (NSDictionary * _Nullable)q_dictionaryWithJSONString:(NSString *)json {
    
    NSError *error = nil;
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers |
                                                                     NSJSONReadingAllowFragments
                                                               error:&error];
    
    if (jsonDict == nil || error) {
        return nil;
    }
    
    return jsonDict;
}

@end


NS_ASSUME_NONNULL_END
