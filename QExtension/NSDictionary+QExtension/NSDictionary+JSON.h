//
//  NSDictionary+JSON.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDictionary (JSON)

/**
 *  JSON 字符串转换成字典
 *
 *  @param json json 字符串
 *
 *  @return 字典
 */
+ (NSDictionary * _Nullable)q_dictionaryWithJSONString:(NSString *)json;

@end


NS_ASSUME_NONNULL_END
