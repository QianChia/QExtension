//
//  NSDictionary+LocaleLog.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSDictionary+LocaleLog.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSDictionary (LocaleLog)

/// 本地化打印输出
- (NSString *)descriptionWithLocale:(nullable id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}"];
    
    return strM;
}

@end


NS_ASSUME_NONNULL_END
