//
//  NSDate+Calculation.m
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSDate+Calculation.h"

NS_ASSUME_NONNULL_BEGIN


#define MORNING_START       0
#define MORNING_END         12

#define AFTERNOON_START     MORNING_END
#define AFTERNOON_END       18

#define EVENING_START       AFTERNOON_END
#define EVENING_END         24

@implementation NSDate (Calculation)

/// 判断是否为今天
- (BOOL)q_isToday {
    
    NSDate *today = [self getCustomDayDateWithDate:[NSDate date]];
    NSDate *otherDate = [self getCustomDayDateWithDate:self];
    
    return ([today compare:otherDate] == NSOrderedSame) ? YES : NO;
}

/// 判断是否为过去的某天
 - (BOOL)q_isPastDay {
     
     NSDate *today = [self getCustomDayDateWithDate:[NSDate date]];
     NSDate *otherDate = [self getCustomDayDateWithDate:self];
     
     return ([today compare:otherDate] == NSOrderedDescending) ? YES : NO;
}

/// 判断是否为将来的某天
- (BOOL)q_isFutureDay {
    
    NSDate *today = [self getCustomDayDateWithDate:[NSDate date]];
    NSDate *otherDate = [self getCustomDayDateWithDate:self];
    
    return ([today compare:otherDate] == NSOrderedAscending) ? YES : NO;
}

/// 判断是否为早上
- (BOOL)q_isMorning {
    
    if (([self compare:[self getCustomHourDateWithHour:MORNING_START]] == NSOrderedDescending) &&
        (([self compare:[self getCustomHourDateWithHour:MORNING_END]] == NSOrderedAscending) ||
         ([self compare:[self getCustomHourDateWithHour:MORNING_END]] == NSOrderedSame))) {
        
        return YES;
    } else {
        return NO;
    }
}

/// 判断是否为下午
- (BOOL)q_isAfternoon {
    
    if (([self compare:[self getCustomHourDateWithHour:AFTERNOON_START]] == NSOrderedDescending) &&
        (([self compare:[self getCustomHourDateWithHour:AFTERNOON_END]] == NSOrderedAscending) ||
         ([self compare:[self getCustomHourDateWithHour:AFTERNOON_END]] == NSOrderedSame))) {
        
        return YES;
    } else {
        return NO;
    }
}

/// 判断是否为晚上
- (BOOL)q_isEvening {
    
    if (([self compare:[self getCustomHourDateWithHour:EVENING_START]] == NSOrderedDescending) &&
        (([self compare:[self getCustomHourDateWithHour:EVENING_END]] == NSOrderedAscending) ||
         ([self compare:[self getCustomHourDateWithHour:EVENING_END]] == NSOrderedSame))) {
        
        return YES;
    } else {
        return NO;
    }
}

/// 计算一天的开始时间
- (NSDate *)q_startOfDay {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    return [cal startOfDayForDate:self];
}

/// 计算一天的结束时间
- (NSDate *)q_endOfDay {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    return [cal startOfDayForDate:[self dateByAddingTimeInterval:3600 * 24]];
}

/// 计算是一周中的第几天
- (NSInteger)q_weekday {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    return [cal component:NSCalendarUnitWeekday fromDate:self];
}

#pragma mark - 助手方法

///
- (NSDate *)getCustomDayDateWithDate:(NSDate *)date {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra |
                                                    NSCalendarUnitYear |
                                                    NSCalendarUnitMonth |
                                                    NSCalendarUnitDay)
                                          fromDate:date];
    
    return [cal dateFromComponents:components];
}

///
- (NSDate *)getCustomHourDateWithHour:(NSInteger)hour {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra |
                                                    NSCalendarUnitYear |
                                                    NSCalendarUnitMonth |
                                                    NSCalendarUnitDay)
                                          fromDate:self];
    
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[components year]];
    [resultComps setMonth:[components month]];
    [resultComps setDay:[components day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc]
                                  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

@end


NS_ASSUME_NONNULL_END
