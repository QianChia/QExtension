//
//  NSString+JSON.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (JSON)

/**
 *  字典转换成 JSON 字符串
 *
 *  @param dic 字典
 *
 *  @return JSON 字符串
 */
+ (NSString * _Nullable)q_jsonStringWithDictionary:(NSDictionary *)dic;

@end


NS_ASSUME_NONNULL_END
