//
//  NSObject+JSONValidator.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSObject+JSONValidator.h"
#import "QJSONValidator.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSObject (JSONValidator)

- (id _Nullable)q_isArray {
    
    if ([self isKindOfClass:[NSArray class]]) {
        return self;
    }
    return nil;
}

- (id _Nullable)q_isDictionary {
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    return nil;
}

- (QValidatorBlock)q_validatorKey {
    
    QValidatorBlock block = ^id(NSString *key, QValidatorPredicate *predicate){
        if (!self.q_isDictionary) {
            return nil;
        }
        
        id jsonValue = [self valueForKey:key];
        [predicate validateValue:jsonValue withKey:key];
        
        if([[predicate failedRequirementDescriptions] count]) {
            return nil;
        }
        
        return jsonValue;
    };
    return block;
}

#pragma mark - id type

- (NSString *)q_stringKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isString.isNotNull];
    NSString *string = keyBlock(key);
    return string;
}

- (NSNumber *)q_numberKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isNumber.isNotNull];
    NSNumber *number = keyBlock(key);
    return number;
}

- (id _Nullable)q_numberOrStringKey:(NSString *)key {
    
    if (!self.q_isDictionary) {
        return nil;
    }
    
    if ([self q_stringKey:key] != nil || [self q_numberKey:key] != nil) {
        id jsonValue = [self valueForKey:key];
        return jsonValue;
    }
    return nil;
}

- (NSDictionary *)q_dictionaryKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isDictionary.isNotNull];
    NSDictionary *dictionary = keyBlock(key);
    return dictionary;
}

- (NSArray *)q_arrayKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isArray.isNotNull];
    NSArray *array = keyBlock(key);
    return array;
}

- (NSNumber *)q_booleanKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isBoolean.isNotNull];
    NSNumber *number = keyBlock(key);
    return number;
}

- (NSNull *)q_nullKey:(NSString *)key {
    
    QIdKeyBlock keyBlock = [self keyBlockWithPredicate:QValidatorPredicate.isNull];
    NSNull *null = keyBlock(key);
    return null;
}

#pragma mark - basic type

#define Q_BASIC_TYPE_FUNCTION_KEY(TYPE, TYPE_METHOD) id value = [self q_numberOrStringKey:key];\
TYPE result = defaultValue;\
if (value) {\
    result = [value TYPE_METHOD];\
}\
return result;

- (NSInteger)q_integerKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] integerValue];
}


- (NSInteger)q_integerKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(NSInteger, integerValue);
}

- (double)q_doubleKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] doubleValue];
}

- (double)q_doubleKey:(NSString *)key defaultValue:(double)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(double, doubleValue);
}

- (float)q_floatKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] floatValue];
}

- (float)q_floatKey:(NSString *)key defaultValue:(float)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(float, floatValue);
}

- (int)q_intKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] intValue];
}

- (int)q_intKey:(NSString *)key defaultValue:(int)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(int, intValue);
}

- (long long)q_longLongKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] longLongValue];
}

- (long long)q_longLongKey:(NSString *)key defaultValue:(long long)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(long long, longLongValue);
}

- (BOOL)q_boolKey:(NSString *)key {
    
    return [[self q_numberOrStringKey:key] boolValue];
}


- (BOOL)q_boolKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    
    Q_BASIC_TYPE_FUNCTION_KEY(BOOL, boolValue);
}

#pragma mark - helper

- (QIdKeyBlock)keyBlockWithPredicate:(QValidatorPredicate *)predicate {
    
    QIdKeyBlock keyBlock = ^id(NSString *key){
        return self.q_validatorKey(key, predicate);
    };
    return keyBlock;
}

@end


NS_ASSUME_NONNULL_END
