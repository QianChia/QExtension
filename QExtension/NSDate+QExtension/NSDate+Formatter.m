//
//  NSDate+Formatter.m
//  QExtension
//
//  Created by JHQ0228 on 2017/4/2.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSDate+Formatter.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSDate (Formatter)

static int secondsOneMinute = 60;
static int secondsOneHour   = 60 * 60;
static int secondsOneDay    = 60 * 60 * 24;
static int secondsOneWeek   = 60 * 60 * 24 * 7;
static int secondsOneMonth  = 60 * 60 * 24 * 30;
static int secondsOneYear   = 60 * 60 * 24 * 30 * 12;

#pragma mark - NSDate

/// 由时间值获取时间字符串
- (NSString *)q_stringWithFormat:(NSString *)format {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter stringFromDate:self];
}

/// 由时间值获取时间 天 字符串
- (NSString *)q_dayStringValue {
    return [self q_stringWithFormat:@"MMddyyyy"];
}

/// 由时间值获取时间 当天 字符串
+ (NSString *)q_currentdayStringValue {
    return [[NSDate date] q_dayStringValue];
}

/// 由时间值获取时间 周 字符串
- (NSString *)q_weekStringValue {
    return [self q_stringWithFormat:@"wwyyyy"];
}

/// 由时间值获取时间 当周 字符串
+ (NSString *)q_currentWeekStringValue {
    return [[NSDate date] q_weekStringValue];
}

/// 由时间值获取时间 月 字符串
- (NSString *)q_monthStringValue {
    return [self q_stringWithFormat:@"MMyyyy"];
}

/// 由时间值获取时间 当月 字符串
+ (NSString *)q_currentMonthStringValue {
    return [[NSDate date] q_monthStringValue];
}

/// 由时间值获取时间 年 字符串
- (NSString *)q_yearStringValue {
    return [self q_stringWithFormat:@"yyyy"];
}

/// 由时间值获取时间 当年 字符串
+ (NSString *)q_currentYearStringValue {
    return [[NSDate date] q_yearStringValue];
}

/// 由时间值获取时间字符串
- (NSString *)q_stringWithFormat:(NSString *)format
                      showYTTDay:(BOOL)isShowD
                       showCYear:(BOOL)isShowY {
    
    NSMutableString *DFormat = [NSMutableString stringWithString:format];
    
    if (isShowY == NO) {
        [self deleteYearFormat:DFormat withDate:self];
    }
    
    NSString *dateString = nil;
    
    if (isShowD) {
        dateString = [self showYTTDayFromDate:self dateFormat:DFormat];
    }
    
    if (dateString == nil) {
        dateString = [self q_stringWithFormat:[DFormat copy]];
    }
    
    return dateString;
}

/// 由时间值获取时间范围
- (NSString *)q_dateRangeJudge {
    
    NSString *lang = [self getPreferredLanguage];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self];
    if (time >= secondsOneYear) {
        
        int year = time/secondsOneYear;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 年前", year];
        }
        return [NSString stringWithFormat:@"%d years ago", year];
        
    } else if (time >= secondsOneMonth) {
        
        int month = time/secondsOneMonth;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 个月前", month];
        }
        return [NSString stringWithFormat:@"%d months ago", month];
        
    } else if (time >= secondsOneWeek) {
        
        int week = time/secondsOneWeek;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 周前", week];
        }
        return [NSString stringWithFormat:@"%d weeks ago", week];
        
    } else if (time < secondsOneWeek && time >= secondsOneDay) {
        
        int day = time/secondsOneDay;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 天前", day];
        }
        return [NSString stringWithFormat:@"%d days ago", day];
        
    } else if (time < secondsOneDay && time >= secondsOneHour) {
        
        int hour = time/secondsOneHour;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 小时前", hour];
        }
        return [NSString stringWithFormat:@"%d hours ago", hour];
        
    } else if (time < secondsOneHour && time >= secondsOneMinute) {
        
        int min = time/secondsOneMinute;
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return [NSString stringWithFormat:@"%d 分钟前", min];
        }
        return [NSString stringWithFormat:@"%d minutes ago", min];
        
    } else {
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            return @"刚刚";
        }
        return @"just";
    }
}

#pragma mark - NSTimeInterval

/// 由时间秒数值获取时间字符串
+ (NSString *)q_stringWithFormat:(NSString *)format
                     dateSeconds:(NSTimeInterval)seconds
                      showYTTDay:(BOOL)isShowD
                       showCYear:(BOOL)isShowY {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *dateString = [date q_stringWithFormat:format
                                         showYTTDay:isShowD
                                          showCYear:isShowY];
    
    return dateString;
}

/// 由时间秒数值获取时间范围
+ (NSString *)q_dateRangeJudgeFromDateSeconds:(NSTimeInterval)seconds {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *dateString = [date q_dateRangeJudge];
    
    return dateString;
}

#pragma mark - 助手方法

/// 显示昨天、今天、明天
- (NSString * _Nullable)showYTTDayFromDate:(NSDate *)date dateFormat:(NSString *)format {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    
    NSString *time      = [dateFormatter stringFromDate:date];
    NSString *yesterday = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-secondsOneDay]];
    NSString *today     = [dateFormatter stringFromDate:[NSDate date]];
    NSString *tomorrow  = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:secondsOneDay]];
    
    NSMutableString *DFormat = [NSMutableString stringWithString:format];
    
    [self deleteYearFormat:DFormat withDate:date];
    [self deleteDayFormat:DFormat withDate:date];
    
    dateFormatter.dateFormat = DFormat;
    
    NSString *lang = [self getPreferredLanguage];
    
    NSString *dateString = nil;
    
    if ([time isEqualToString:yesterday]) {
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            dateString = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
        } else {
            dateString = [NSString stringWithFormat:@"Yesterday %@", [dateFormatter stringFromDate:date]];
        }
        
    } else if ([time isEqualToString:today]) {
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            dateString = [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:date]];
        } else {
            dateString = [NSString stringWithFormat:@"Today %@", [dateFormatter stringFromDate:date]];
        }
        
    } else if ([time isEqualToString:tomorrow]) {
        
        if ([lang isEqualToString:@"zh-Hans"]) {
            dateString = [NSString stringWithFormat:@"明天 %@", [dateFormatter stringFromDate:date]];
        } else {
            dateString = [NSString stringWithFormat:@"Tomorrow %@", [dateFormatter stringFromDate:date]];
        }
    }
    return dateString;
}

/// 去除年份格式
- (void)deleteYearFormat:(NSMutableString *)format withDate:(NSDate *)date {
    
    if ([format containsString:@"yy"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy";
        
        NSString *time        = [dateFormatter stringFromDate:date];
        NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        
        if ([time isEqualToString:currentYear]) {
            
            NSUInteger location1 = 0;
            NSUInteger location2 = 0;
            
            NSRange range1 = [format rangeOfString:@"yy"];
            location1 = range1.location;
            
            NSRange range2 = [format rangeOfString:@"MM"];
            if (range2.location != NSNotFound) {
                
                location2 = range2.location;
                
            } else {
                
                NSRange range3 = [format rangeOfString:@"yyyy"];
                if (range3.location != NSNotFound) {
                    location2 = location1 + 3;
                } else {
                    location2 = location1 + 1;
                }
            }
            
            if (location2 > location1) {
                NSRange range = NSMakeRange(location1, location2 - location1);
                [format replaceCharactersInRange:range withString:@""];
            }
        }
    }
}

/// 去除月份天数格式
- (void)deleteDayFormat:(NSMutableString *)format withDate:(NSDate *)date {
    
    if ([format containsString:@"MM"] || [format containsString:@"dd"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyyMMdd";
        
        NSString *time      = [dateFormatter stringFromDate:date];
        NSString *yesterday = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-secondsOneDay]];
        NSString *today     = [dateFormatter stringFromDate:[NSDate date]];
        NSString *tomorrow  = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:secondsOneDay]];
        
        if ([time isEqualToString:yesterday] ||
            [time isEqualToString:today]     ||
            [time isEqualToString:tomorrow]    ) {
            
            NSUInteger location1 = 0;
            NSUInteger location2 = 0;
            
            NSRange range1 = [format rangeOfString:@"MM"];
            if (range1.location != NSNotFound) {
                
                location1 = range1.location;
                
                NSRange range2 = [format rangeOfString:@"dd"];
                if (range2.location != NSNotFound) {
                    location2 = range2.location + 2;
                } else {
                    location2 = location1 + 2;
                }
                
            } else {
                
                NSRange range2 = [format rangeOfString:@"dd"];
                location1 = range2.location;
                
                location2 = location1 + 2;
            }
            
            if (location2 > location1) {
                NSRange range = NSMakeRange(location1, location2 - location1 + 1);
                [format replaceCharactersInRange:range withString:@""];
            }
        }
    }
}

/// 获取本机现在用的语言
- (NSString *)getPreferredLanguage {
    
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
