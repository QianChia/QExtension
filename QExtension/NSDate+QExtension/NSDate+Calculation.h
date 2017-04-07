//
//  NSDate+Calculation.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (Calculation)

/**
 *  判断是否为今天
 *
 *  @return YES 是今天
 */
- (BOOL)q_isToday;

/**
 *  判断是否为过去的某天
 *
 *  @return YES 是过去的某天
 */
- (BOOL)q_isPastDay;

/**
 *  判断是否为将来的某天
 *
 *  @return YES 是将来的某天
 */
- (BOOL)q_isFutureDay;

/**
 *  判断是否为早上
 *
 *  @return YES 是早上
 */
- (BOOL)q_isMorning;

/**
 *  判断是否为下午
 *
 *  @return YES 是下午
 */
- (BOOL)q_isAfternoon;

/**
 *  判断是否为晚上
 *
 *  @return YES 是晚上
 */
- (BOOL)q_isEvening;

/**
 *  计算一天的开始时间
 *
 *  @return
 */
- (NSDate *)q_startOfDay;

/**
 *  计算一天的结束时间
 *
 *  @return
 */
- (NSDate *)q_endOfDay;

/**
 *  计算是一周中的第几天
 *
 *  @return 一周中的某天，范围 1-7
 */
- (NSInteger)q_weekday;

@end


NS_ASSUME_NONNULL_END
