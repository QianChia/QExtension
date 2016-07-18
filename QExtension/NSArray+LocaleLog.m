//
//  NSArray+LocaleLog.m
//  QExtension
//
//  Created by JHQ0228 on 16/7/2.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "NSArray+LocaleLog.h"

@implementation NSArray (LocaleLog)

/*
 Xcode 没有针对国际化语言做特殊处理，直接 Log 数组，只打印 UTF8 的编码，不能显示中文。重写这个方法，就能够解决输出问题，这个方法是专门为了本地话提供的一个调试方法，只要重写，不需要导入头文件，程序中所有的 NSLog 数组的方法，都会被替代。
 */

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [strM appendFormat:@"\t%@", obj];
        if (idx != self.count - 1) [strM appendFormat:@",\n"];
    }];
    
    [strM appendString:@"\n)"];
    
    return strM;
}

@end
