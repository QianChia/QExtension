//
//  NSString+Date.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/22.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+Date.h"

NS_ASSUME_NONNULL_BEGIN


static int secondsOneMinute = 60;
static int secondsOneHour   = 60 * 60;
static int secondsOneDay    = 60 * 60 * 24;
static int secondsOneWeek   = 60 * 60 * 24 * 7;
static int secondsOneMonth  = 60 * 60 * 24 * 30;
static int secondsOneYear   = 60 * 60 * 24 * 30 * 12;


@implementation NSString (Date)

/// 由时间值获取时间字符串
+ (NSString *)q_dateStringFromDate:(NSDate *)date
                        dateFormat:(NSString *)format
                        showYTTDay:(BOOL)isShowD
                         showCYear:(BOOL)isShowY {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSMutableString *DFormat = [NSMutableString stringWithString:format];
    
    if (isShowY == NO) {
        [self deleteYearFormat:DFormat withDate:date];
    }
    
    NSString *dateString = nil;
    
    if (isShowD) {
        dateString = [self showYTTDayFromDate:date dateFormat:DFormat];
    }
    
    if (dateString == nil) {
        
        dateFormatter.dateFormat = [DFormat copy];
        dateString = [dateFormatter stringFromDate:date];
    }
    
    return dateString;
}

/// 由时间秒数值获取时间字符串
+ (NSString *)q_dateStringFromDateSeconds:(NSTimeInterval)seconds
                               dateFormat:(NSString *)format
                               showYTTDay:(BOOL)isShowD
                                showCYear:(BOOL)isShowY {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *dateString = [self q_dateStringFromDate:date
                                           dateFormat:format
                                           showYTTDay:isShowD
                                            showCYear:isShowY];
    
    return dateString;
}

/// 显示昨天、今天、明天
+ (NSString * _Nullable)showYTTDayFromDate:(NSDate *)date dateFormat:(NSString *)format {
    
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
    
    NSString *dateString = nil;
    
    if ([time isEqualToString:yesterday]) {
        
        dateString = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
        
    } else if ([time isEqualToString:today]) {
        
        dateString = [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:date]];
        
    } else if ([time isEqualToString:tomorrow]) {
        
        dateString = [NSString stringWithFormat:@"明天 %@", [dateFormatter stringFromDate:date]];
    }
    return dateString;
}

/// 去除年份格式
+ (void)deleteYearFormat:(NSMutableString *)format withDate:(NSDate *)date {
    
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
+ (void)deleteDayFormat:(NSMutableString *)format withDate:(NSDate *)date {
    
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

/// 由时间值判断时间范围
+ (NSString *)q_dateJudgeStringFromDate:(NSDate *)date {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    
    if (time >= secondsOneYear) {
        
        int year = time/secondsOneYear;
        return [NSString stringWithFormat:@"%d 年前", year];
        
    } else if (time >= secondsOneMonth) {
        
        int month = time/secondsOneMonth;
        return [NSString stringWithFormat:@"%d 个月前", month];
        
    } else if (time >= secondsOneWeek) {
        
        int week = time/secondsOneWeek;
        return [NSString stringWithFormat:@"%d 周前", week];
        
    } else if (time < secondsOneWeek && time >= secondsOneDay) {
        
        int day = time/secondsOneDay;
        return [NSString stringWithFormat:@"%d 天前", day];
        
    } else if (time < secondsOneDay && time >= secondsOneHour) {
        
        int hour = time/secondsOneHour;
        return [NSString stringWithFormat:@"%d 小时前", hour];
        
    } else if (time < secondsOneHour && time >= secondsOneMinute) {
        
        int min = time/secondsOneMinute;
        return [NSString stringWithFormat:@"%d 分钟前", min];
        
    } else {
        
        return @"刚刚";
    }
}

/// 由时间秒数值判断时间范围
+ (NSString *)q_dateJudgeStringFromDateSeconds:(NSTimeInterval)seconds {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *dateString = [self q_dateJudgeStringFromDate:date];
    
    return dateString;
}

@end


NS_ASSUME_NONNULL_END
