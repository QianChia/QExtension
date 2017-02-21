//
//  NSString+Date.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/22.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Date)

/**
 *  由时间值获取时间字符串
 *
 *  @param date     时间值
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
 *  @param isShowD  是否显示 昨天、今天、明天
 *  @param isShowY  是否显示当前的年份
 *
 *  @return 时间字符串
 */
+ (NSString *)q_dateStringFromDate:(NSDate *)date
                        dateFormat:(NSString *)format
                        showYTTDay:(BOOL)isShowD
                         showCYear:(BOOL)isShowY;

/**
 *  由时间秒数值获取时间字符串
 *
 *  @param date     时间秒数值
 *  @param format   时间显示格式
 *  @param isShowD  是否显示 昨天、今天、明天
 *  @param isShowY  是否显示当前的年份
 *
 *  @return 时间字符串
 */
+ (NSString *)q_dateStringFromDateSeconds:(NSTimeInterval)seconds
                               dateFormat:(NSString *)format
                               showYTTDay:(BOOL)isShowD
                                showCYear:(BOOL)isShowY;

/**
 *  由时间值判断时间范围
 *
 *  @param date     时间值
 *
 *  @return 时间范围字符串
 */
+ (NSString *)q_dateJudgeStringFromDate:(NSDate *)date;

/**
 *  由时间秒数值判断时间范围
 *
 *  @param date     时间秒数值
 *
 *  @return 时间范围字符串
 */
+ (NSString *)q_dateJudgeStringFromDateSeconds:(NSTimeInterval)seconds;

















@end


NS_ASSUME_NONNULL_END
