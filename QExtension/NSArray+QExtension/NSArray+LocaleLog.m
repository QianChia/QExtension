//
//  NSArray+LocaleLog.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSArray+LocaleLog.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSArray (LocaleLog)

/// 本地化打印输出
- (NSString *)descriptionWithLocale:(nullable id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [strM appendFormat:@"\t%@", obj];
        if (idx != self.count - 1) [strM appendFormat:@",\n"];
    }];
    
    [strM appendString:@"\n)"];
    
    return strM;
}

@end


NS_ASSUME_NONNULL_END
