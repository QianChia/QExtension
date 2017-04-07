//
//  NSDate+Formatter.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/2.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (Formatter)

#pragma mark - NSDate

/**
 *  由时间值获取时间字符串
 *
 *  @param format   时间显示格式
 *                     G -- 纪元
 *                     y -- 年
 *                     M -- 月
 *                     w -- 一年中的第几周
 *                     W -- 一个月中的第几周
 *                     F -- 月份包含的周
 *                     D -- 一年中的第几天
 *                     d -- 一个月中的第几天
 *                     E -- 星期几
 *                     a -- 上午(AM)/下午(PM)
 *                     H -- 24小时制
 *                     h -- 12小时制
 *                     K -- 12小时制
 *                     k -- 24小时制
 *                     m -- 分钟
 *                     s -- 秒
 *                     S -- 毫秒
 *                     z -- 时区
 *                     Z -- 时区
 *
 *  @return 时间字符串
 */
- (NSString *)q_stringWithFormat:(NSString *)format;

/**
 *  由时间值获取时间 天 字符串
 *
 *  @return 时间字符串
 */
- (NSString *)q_dayStringValue;

/**
 *  由时间值获取时间 当天 字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)q_currentdayStringValue;

/**
 *  由时间值获取时间 周 字符串
 *
 *  @return 时间字符串
 */
- (NSString *)q_weekStringValue;

/**
 *  由时间值获取时间 当周 字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)q_currentWeekStringValue;

/**
 *  由时间值获取时间 月 字符串
 *
 *  @return 时间字符串
 */
- (NSString *)q_monthStringValue;

/**
 *  由时间值获取时间 当月 字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)q_currentMonthStringValue;

/**
 *  由时间值获取时间 年 字符串
 *
 *  @return 时间字符串
 */
- (NSString *)q_yearStringValue;

/**
 *  由时间值获取时间 当年 字符串
 *
 *  @return 时间字符串
 */
+ (NSString *)q_currentYearStringValue;

/**
 *  由时间值获取时间字符串
 *
 *  @param format   时间显示格式
 *  @param isShowD  是否显示 昨天、今天、明天
 *  @param isShowY  是否显示当前的年份
 *
 *  @return 时间字符串
 */
- (NSString *)q_stringWithFormat:(NSString *)format
                      showYTTDay:(BOOL)isShowD
                       showCYear:(BOOL)isShowY;

/**
 *  由时间值获取时间范围
 *
 *  @return 时间范围字符串
 */
- (NSString *)q_dateRangeJudge;

#pragma mark - NSTimeInterval

/**
 *  由时间秒数值获取时间字符串
 *
 *  @param format   时间显示格式
 *  @param seconds  时间秒数值
 *  @param isShowD  是否显示 昨天、今天、明天
 *  @param isShowY  是否显示当前的年份
 *
 *  @return 时间字符串
 */
+ (NSString *)q_stringWithFormat:(NSString *)format
                     dateSeconds:(NSTimeInterval)seconds
                      showYTTDay:(BOOL)isShowD
                       showCYear:(BOOL)isShowY;

/**
 *  由时间秒数值获取时间范围
 *
 *  @param seconds  时间秒数值
 *
 *  @return 时间范围字符串
 */
+ (NSString *)q_dateRangeJudgeFromDateSeconds:(NSTimeInterval)seconds;

@end


NS_ASSUME_NONNULL_END
