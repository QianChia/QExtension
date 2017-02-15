//
//  QJSONValidator.h
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define QJSONValidatorErrorDomain                   @"QJSONValidatorErrorDomain"
#define QJSONValidatorFailingKeys                   @"QJSONValidatorFailingKeys"

#define QJSONValidatorErrorBadRequirementsParameter 0
#define QJSONValidatorErrorBadJSONParameter         1
#define QJSONValidatorErrorInvalidJSON              2


#pragma mark - QJSONValidator

typedef BOOL (^ValidatorBlock)(NSString *jsonKey, id jsonValue);

@interface QJSONValidator : NSObject

/**
 *  JSON 数据验证
 *
 *  <p> JSON 数据必须是 NSArray 或者 NSDictionary 格式，
 *      Keys  : 必须是 NSString 类型，
 *      Values: 必须是 NSString/NSNumber/NSNull/NSDictionary/NSArray 类型 <p>
 *
 *  <p> 验证条件必须是以下格式的 NSDictionary 类型:
 *      Keys  : NSString/NSNumber
 *      Values: QValidatorPredicate/NSDictionary <p>
 *
 *  <p> 错误信息可能为 nil，否则必须为 NSError 类型。 <p>
 *
 *  @param json             json 数据
 *  @param requirements     验证条件
 *  @param error            错误信息
 *
 *  @return 所有条件都满足时返回 YES
 */
+ (BOOL)q_validateValuesFrom:(id)json
            withRequirements:(NSDictionary *)requirements
                       error:(NSError **)error;

/**
 *  格式化错误信息
 *
 *  @param error    错误信息
 *
 *  @return 格式化的错误信息字符串
 */
+ (NSString *)q_prettyStringGivenQJSONValidatorError:(NSError *)error;

/**
 *  设置是否打印输出错误信息
 *
 *  @param shouldSuppressLogging    是否打印输出
 */
+ (void)q_setShouldSuppressLogging:(BOOL)shouldSuppressLogging;

@end


#pragma mark - QValidatorPredicate

@interface QValidatorPredicate : NSObject

- (void)validateValue:(id _Nullable)value withKey:(NSString *)key;
- (NSMutableArray *)failedRequirementDescriptions;

+ (instancetype)isOptional;                             // Evaluate the other predicates only if the key exists
+ (instancetype)hasSubstring:(NSString *)substring;     // Require NSString with substring
+ (instancetype)isString;
+ (instancetype)isNumber;
+ (instancetype)isDictionary;
+ (instancetype)isArray;
+ (instancetype)isBoolean;
+ (instancetype)isNull;                                 // Require value == [NSNull null]
+ (instancetype)isNotNull;                              // Require value != [NSNull null]
+ (instancetype)validateValueWithBlock:(ValidatorBlock)block;   // For custom validations, given the JSON key and corresponding value (could be nil, [NSNull null], NSNumber, NSArray, NSDictionary, or NSString), return YES if valid and NO if invalid

/// Array
+ (instancetype)valuesWithRequirements:(NSDictionary *)requirements;    // Evaluate an array with requirements

/// Array/String methods
+ (instancetype)lengthIsLessThan:(NSNumber *)value;
+ (instancetype)lengthIsLessOrEqualTo:(NSNumber *)value;
+ (instancetype)lengthIsEqualTo:(NSNumber *)value;
+ (instancetype)lengthIsNotEqualTo:(NSNumber *)value;
+ (instancetype)lengthIsGreaterThanOrEqualTo:(NSNumber *)value;
+ (instancetype)lengthIsGreaterThan:(NSNumber *)value;

/// Number/String methods
+ (instancetype)valueIsLessThan:(NSNumber *)value;
+ (instancetype)valueIsLessOrEqualTo:(NSNumber *)value;
+ (instancetype)valueIsEqualTo:(id)value;
+ (instancetype)valueIsNotEqualTo:(id)value;
+ (instancetype)valueIsGreaterThanOrEqualTo:(NSNumber *)value;
+ (instancetype)valueIsGreaterThan:(NSNumber *)value;

/// String only methods
+ (instancetype)matchesRegularExpression:(NSRegularExpression *)expression;

#pragma mark Corresponding Instance Methods

- (instancetype)isOptional;
- (instancetype)hasSubstring:(NSString *)substring;
- (instancetype)isString;
- (instancetype)isNumber;
- (instancetype)isDictionary;
- (instancetype)isArray;
- (instancetype)isBoolean;
- (instancetype)isNull;
- (instancetype)isNotNull;
- (instancetype)validateValueWithBlock:(ValidatorBlock)block;

/// Array
- (instancetype)valuesWithRequirements:(NSDictionary *)requirements;

/// Array/String methods
- (instancetype)lengthIsLessThan:(NSNumber *)value;
- (instancetype)lengthIsLessOrEqualTo:(NSNumber *)value;
- (instancetype)lengthIsEqualTo:(NSNumber *)value;
- (instancetype)lengthIsNotEqualTo:(NSNumber *)value;
- (instancetype)lengthIsGreaterThanOrEqualTo:(NSNumber *)value;
- (instancetype)lengthIsGreaterThan:(NSNumber *)value;

/// Number/String methods
- (instancetype)valueIsLessThan:(NSNumber *)value;
- (instancetype)valueIsLessThanOrEqualTo:(NSNumber *)value;
- (instancetype)valueIsEqualTo:(id)value;
- (instancetype)valueIsNotEqualTo:(id)value;
- (instancetype)valueIsGreaterThanOrEqualTo:(NSNumber *)value;
- (instancetype)valueIsGreaterThan:(NSNumber *)value;

/// String only methods
- (instancetype)matchesRegularExpression:(NSRegularExpression *)expression;

@end


NS_ASSUME_NONNULL_END
