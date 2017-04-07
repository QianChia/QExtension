//
//  NSString+Language.m
//  QExtension
//
//  Created by JHQ0228 on 2017/4/2.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+Language.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (Language)

/// 获取本机现在用的语言
+ (NSString *)q_getPreferredLanguage {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    
    NSString *lang = nil;
    if ([preferredLang containsString:@"zh-Hans-"]) {
        lang = @"zh-Hans";
    } else if ([preferredLang containsString:@"zh-Hant-"]) {
        lang = @"zh-Hant";
    } else if ([preferredLang containsString:@"ja-"]) {
        lang = @"ja";
    } else if ([preferredLang containsString:@"en-"]) {
        lang = @"en";
    } else {
        lang = @"en";
    }
    
    return lang;
}

@end


NS_ASSUME_NONNULL_END
