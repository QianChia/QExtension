//
//  NSObject+JSONValidator.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class QValidatorPredicate;

typedef id _Nullable (^QValidatorBlock)(NSString *key, QValidatorPredicate *predicate);
typedef id _Nullable (^QIdKeyBlock)(NSString *key);

@interface NSObject (JSONValidator)

- (id _Nullable)q_isArray;
- (id _Nullable)q_isDictionary;

- (QValidatorBlock)q_validatorKey;

- (NSString *)q_stringKey:(NSString *)key;
- (NSNumber *)q_numberKey:(NSString *)key;
- (id _Nullable)q_numberOrStringKey:(NSString *)key;

- (NSDictionary *)q_dictionaryKey:(NSString *)key;
- (NSArray *)q_arrayKey:(NSString *)key;
- (NSNumber *)q_booleanKey:(NSString *)key;

- (NSNull *)q_nullKey:(NSString *)key;

- (NSInteger)q_integerKey:(NSString *)key;
- (NSInteger)q_integerKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

- (double)q_doubleKey:(NSString *)key;
- (double)q_doubleKey:(NSString *)key defaultValue:(double)defaultValue;

- (float)q_floatKey:(NSString *)key;
- (float)q_floatKey:(NSString *)key defaultValue:(float)defaultValue;

- (int)q_intKey:(NSString *)key;
- (int)q_intKey:(NSString *)key defaultValue:(int)defaultValue;

- (long long)q_longLongKey:(NSString *)key;
- (long long)q_longLongKey:(NSString *)key defaultValue:(long long)defaultValue;

- (BOOL)q_boolKey:(NSString *)key;
- (BOOL)q_boolKey:(NSString *)key defaultValue:(BOOL)defaultValue;

@end


NS_ASSUME_NONNULL_END
