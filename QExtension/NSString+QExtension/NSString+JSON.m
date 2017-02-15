//
//  NSString+JSON.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+JSON.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (JSON)

/// 字典转换成 JSON 字符串
+ (NSString * _Nullable)q_jsonStringWithDictionary:(NSDictionary *)dic {
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:0
                                                         error:&error];
    
    if (jsonData == nil || error) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end


NS_ASSUME_NONNULL_END
