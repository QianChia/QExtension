//
//  QJSONValidator.m
//  QExtension
//
//  Created by JHQ0228 on 2017/2/16.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QJSONValidator.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QJSONValidator

static BOOL QJSONValidatorShouldSuppressWarnings;

@implementation QJSONValidator

/// JSON 数据验证
+ (BOOL)q_validateValuesFrom:(id)json
            withRequirements:(NSDictionary *)requirements
                       error:(NSError **)error {
    
    if (!json) {
        
        [QJSONValidator log:@"QJSONValidator Error: json parameter is nil -- there is nothing to validate. Returning NO"];
        
        if (error) {
            *error = [NSError errorWithDomain:QJSONValidatorErrorDomain
                                         code:QJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"json parameter is nil",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid json"
                                                }];
        }
        
        return NO;
    }
    
    if (![json isKindOfClass:[NSDictionary class]] && ![json isKindOfClass:[NSArray class]]) {
        
        [QJSONValidator log:@"QJSONValidator Error: json parameter is not valid JSON (it is not an NSArray or NSDictionary). Returning NO"];
        
        if (error) {
            *error = [NSError errorWithDomain:QJSONValidatorErrorDomain
                                         code:QJSONValidatorErrorBadJSONParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"json parameter is not an NSArray or NSDictionary",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid json"
                                                }];
        }
        return NO;
    }
    
    if (!requirements) {
        
        [QJSONValidator log:@"QJSONValidator Error: requirements parameter is nil -- there are no requirements. Returning NO"];
        
        if (error) {
            *error = [NSError errorWithDomain:QJSONValidatorErrorDomain
                                         code:QJSONValidatorErrorBadRequirementsParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"requirements parameter is nil",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid requirements"
                                                }];
        }
        return NO;
    }
    
    if (![requirements isKindOfClass:[NSDictionary class]]) {
        
        [QJSONValidator log:@"QJSONValidator Error: requirements parameter is not an NSDictionary. Returning NO"];
        
        if (error) {
            *error = [NSError errorWithDomain:QJSONValidatorErrorDomain
                                         code:QJSONValidatorErrorBadRequirementsParameter
                                     userInfo:@{
                                                NSLocalizedDescriptionKey : @"Nothing to validate",
                                                NSLocalizedFailureReasonErrorKey : @"requirements parameter is not an NSDictionary",
                                                NSLocalizedRecoverySuggestionErrorKey : @"pass in valid requirements"
                                                }];
        }
        return NO;
    }
    
    return [QJSONValidator validateValuesFrom:json
                             withRequirements:requirements
                                        error:error
                                     userInfo:[@{} mutableCopy]];
}

/// 数据验证
+ (BOOL)validateValuesFrom:(id _Nullable)json
          withRequirements:(NSDictionary *)requirements
                     error:(NSError **)error
                  userInfo:(NSMutableDictionary *)userInfo {
    
    __block BOOL encounteredError = NO;
    [requirements enumerateKeysAndObjectsUsingBlock:^(id requirementsKey, id requirementsValue, BOOL *stop) {
        
        id jsonValue;
        
        if ([json isKindOfClass:[NSArray class]] && [requirementsKey isKindOfClass:[NSNumber class]] && [json count] > [requirementsKey unsignedIntegerValue]) {
            jsonValue = [json objectAtIndex:[requirementsKey unsignedIntegerValue]];
        } else if ([json isKindOfClass:[NSDictionary class]]) {
            jsonValue = [json objectForKey:requirementsKey];
        } else {
            jsonValue = nil;
        }
        
        if ([requirementsValue isKindOfClass:[QValidatorPredicate class]] && [requirementsKey isKindOfClass:[NSString class]]) {
            
            [(QValidatorPredicate *)requirementsValue validateValue:jsonValue withKey:requirementsKey];
            
            if ([[(QValidatorPredicate *)requirementsValue failedRequirementDescriptions] count]) {
                
                NSMutableDictionary *failingKeys = [userInfo objectForKey:QJSONValidatorFailingKeys];
                
                if (failingKeys) {
                    failingKeys = [failingKeys mutableCopy];
                } else {
                    failingKeys = [NSMutableDictionary dictionary];
                }
                
                [failingKeys setObject:[(QValidatorPredicate *)requirementsValue failedRequirementDescriptions] forKey:requirementsKey];
                [userInfo setObject:failingKeys forKey:QJSONValidatorFailingKeys];
            }
        } else if ([requirementsValue isKindOfClass:[NSDictionary class]]) {
            
            [QJSONValidator validateValuesFrom:jsonValue
                              withRequirements:requirementsValue
                                         error:error
                                      userInfo:userInfo];
        } else {
            
            [QJSONValidator log:[NSString stringWithFormat:@"QJSONValidator Error: requirements parameter isn't valid. Value (%@) isn't an QValidatorPredicate or NSDictionary or NSNumber. Returning NO", requirementsValue]];
            
            encounteredError = YES;
            if (error) {
                *error = [NSError errorWithDomain:QJSONValidatorErrorDomain
                                             code:QJSONValidatorErrorBadRequirementsParameter
                                         userInfo:@{
                                                    NSLocalizedDescriptionKey : @"Requirements not setup correctly",
                                                    NSLocalizedFailureReasonErrorKey : [NSString stringWithFormat:@"Requirements key (%@) with value (%@) is not an QValidatorPredicate or NSDictionary", requirementsKey, requirementsValue],
                                                    NSLocalizedRecoverySuggestionErrorKey : @"Review requirements syntax"
                                                    }];
            }
            
            *stop = YES;
        }
    }];
    
    if (encounteredError) {
        return NO;
    }
    
    if ([[userInfo allKeys] count]) {
        if (error) {
            [userInfo setObject:@"JSON did not validate" forKey:NSLocalizedDescriptionKey];
            [userInfo setObject:@"At least one requirement wasn't met" forKey:NSLocalizedFailureReasonErrorKey];
            [userInfo setObject:@"Perhaps use backup JSON" forKey:NSLocalizedRecoverySuggestionErrorKey];
            
            *error = [NSError errorWithDomain:QJSONValidatorErrorDomain code:QJSONValidatorErrorInvalidJSON userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}

/// 格式化错误信息
+ (NSString *)q_prettyStringGivenQJSONValidatorError:(NSError *)error {
    
    __block NSString *prettyString = @"";
    
    NSDictionary *failingKeys = [[error userInfo] objectForKey:QJSONValidatorFailingKeys];
    
    [failingKeys enumerateKeysAndObjectsUsingBlock:^(NSString *badKey, NSArray *requirements, BOOL *stop) {
        prettyString = [prettyString stringByAppendingFormat:@"\n* %@\n", badKey];
        
        for (NSString *requirement in requirements) {
            prettyString = [prettyString stringByAppendingFormat:@"     * %@\n", requirement];
        }
    }];
    
    return prettyString;
}

/// 设置是否打印输出错误信息
+ (void)q_setShouldSuppressLogging:(BOOL)shouldSuppressLogging {
    
    QJSONValidatorShouldSuppressWarnings = shouldSuppressLogging;
}

/**
 *  打印输出错误信息
 *
 *  @param warning  错误信息
 */
+ (void)log:(NSString *)warning {
    
    if (!QJSONValidatorShouldSuppressWarnings) {
        NSLog(@"%@", warning);
    }
}

@end


#pragma mark - QValidatorPredicate

@interface QValidatorPredicate ()

@property (nonatomic) BOOL optional;

/// An array of ValidatorBlocks
@property (nonatomic, strong) NSMutableArray *requirements;

/// An array of descriptions for failures. ValidatorBlocks are supposed to populate them
@property (nonatomic, strong) NSMutableArray *failedRequirementDescriptions;

@end

@implementation QValidatorPredicate

- (id)init {
    
    if ((self = [super init])) {
        self.requirements = [NSMutableArray array];
        self.failedRequirementDescriptions = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)isOptional {
    QValidatorPredicate *predicate = [self new];
    return [predicate isOptional];
}

+ (instancetype)hasSubstring:(NSString *)substring {
    QValidatorPredicate *predicate = [self new];
    return [predicate hasSubstring:substring];
}

+ (instancetype)isString {
    QValidatorPredicate *predicate = [self new];
    return [predicate isString];
}

+ (instancetype)isNumber {
    QValidatorPredicate *predicate = [self new];
    return [predicate isNumber];
}

+ (instancetype)isDictionary {
    QValidatorPredicate *predicate = [self new];
    return [predicate isDictionary];
}

+ (instancetype)isArray {
    QValidatorPredicate *predicate = [self new];
    return [predicate isArray];
}

+ (instancetype)isBoolean {
    QValidatorPredicate *predicate = [self new];
    return [predicate isBoolean];
}

+ (instancetype)isNull {
    QValidatorPredicate *predicate = [self new];
    return [predicate isNull];
}

+ (instancetype)isNotNull {
    QValidatorPredicate *predicate = [self new];
    return [predicate isNotNull];
}

+ (instancetype)validateValueWithBlock:(ValidatorBlock)block {
    QValidatorPredicate *predicate = [self new];
    return [predicate validateValueWithBlock:block];
}

+ (instancetype)lengthIsLessThan:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsLessThan:value];
}

+ (instancetype)valuesWithRequirements:(NSDictionary *)requirements {
    QValidatorPredicate *predicate = [self new];
    return [predicate valuesWithRequirements:requirements];
}

+ (instancetype)lengthIsLessOrEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsLessOrEqualTo:value];
}

+ (instancetype)lengthIsEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsEqualTo:value];
}

+ (instancetype)lengthIsNotEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsNotEqualTo:value];
}

+ (instancetype)lengthIsGreaterThanOrEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsGreaterThanOrEqualTo:value];
}

+ (instancetype)lengthIsGreaterThan:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate lengthIsGreaterThan:value];
}

+ (instancetype)valueIsLessThan:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsLessThan:value];
}

+ (instancetype)valueIsLessOrEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsLessThanOrEqualTo:value];
}

+ (instancetype)valueIsEqualTo:(id)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsEqualTo:value];
}

+ (instancetype)valueIsNotEqualTo:(id)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsNotEqualTo:value];
}

+ (instancetype)valueIsGreaterThanOrEqualTo:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsGreaterThanOrEqualTo:value];
}

+ (instancetype)valueIsGreaterThan:(NSNumber *)value {
    QValidatorPredicate *predicate = [self new];
    return [predicate valueIsGreaterThan:value];
}

+ (instancetype)matchesRegularExpression:(NSRegularExpression *)expression {
    QValidatorPredicate *predicate = [self new];
    return [predicate matchesRegularExpression:expression];
}

#pragma mark Instance Methods

- (instancetype)isOptional {
    self.optional = YES;
    return self;
}

- (instancetype)hasSubstring:(NSString *)substring {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if ([jsonValue isKindOfClass:[NSString class]] && [substring isKindOfClass:[NSString class]]) {
            return [(NSString *)jsonValue rangeOfString:substring].location != NSNotFound;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Value (%@) must contain substring %@", jsonValue, substring]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isString {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSString class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSString, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isNumber {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSNumber class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isDictionary {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSDictionary class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSDictionary, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isArray {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSArray class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSArray, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isBoolean {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSNumber class]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires BOOL (NSNumber), given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isNull {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isEqual:[NSNull null]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires null, given (%@)", jsonValue]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)isNotNull {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if(![jsonValue isEqual:[NSNull null]]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires non-null value, given (%@)", jsonValue]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)validateValueWithBlock:(ValidatorBlock)developerBlock {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        BOOL developerReturnValue = developerBlock(jsonKey, jsonValue);
        if(developerReturnValue) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Custom block for with value (%@) returned NO", jsonValue]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valuesWithRequirements:(NSDictionary *)requirements {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            BOOL isValid = YES;
            
            for (id object in (NSArray *)jsonValue) {
                
                NSError *error = nil;
                
                if (![QJSONValidator q_validateValuesFrom:object
                                         withRequirements:requirements
                                                    error:&error]) {
                    isValid = NO;
                    
                    id errorMessageObject = error.userInfo[QJSONValidatorFailingKeys];
                    if (errorMessageObject != nil) {
                        [weakSelf.failedRequirementDescriptions addObject:error.userInfo[QJSONValidatorFailingKeys]];
                    }
                }
            }
            return isValid;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSArray, given (%@)", [jsonValue class]]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsLessThan:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length < [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count greater than or equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsLessOrEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length <= [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count greater than (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length == [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsNotEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length != [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsGreaterThanOrEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length >= [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count less than (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)lengthIsGreaterThan:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSUInteger length;
        
        if ([jsonValue isKindOfClass:[NSArray class]]) {
            length = [(NSArray *)jsonValue count];
        } else if ([jsonValue isKindOfClass:[NSString class]]) {
            length = [(NSString *)jsonValue length];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length (NSString) or count (NSArray)"]];
            return NO;
        }
        
        if (length > [value unsignedIntegerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires length or count less than or equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsLessThan:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSInteger integerValue;
        
        if ([jsonValue isKindOfClass:[NSNumber class]]) {
            integerValue = [(NSNumber *)jsonValue integerValue];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (integerValue < [value integerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value greater than or equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsLessThanOrEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSInteger integerValue;
        
        if ([jsonValue isKindOfClass:[NSNumber class]]) {
            integerValue = [(NSNumber *)jsonValue integerValue];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (integerValue <= [value integerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value greater than (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsEqualTo:(id)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if([jsonValue isKindOfClass:[NSNumber class]] && [value isKindOfClass:[NSNumber class]]) {
            if ([(NSNumber *)jsonValue isEqualToNumber:value] ) {
                return YES;
            } else {
                [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value not equal to (%@)", value]];
                return NO;
            }
        } else if ([jsonValue isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
            if ([(NSString *)jsonValue isEqualToString:jsonValue]) {
                return YES;
            } else {
                [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value not equal to (%@)", value]];
                return NO;
            }
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Error comparing value (%@) with value (%@)", jsonValue, value]];
            return NO;
        }
        
        
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsNotEqualTo:(id)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSInteger integerValue;
        
        if ([jsonValue isKindOfClass:[NSNumber class]]) {
            integerValue = [(NSNumber *)jsonValue integerValue];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (integerValue != [value integerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsGreaterThanOrEqualTo:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSInteger integerValue;
        
        if ([jsonValue isKindOfClass:[NSNumber class]]) {
            integerValue = [(NSNumber *)jsonValue integerValue];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (integerValue >= [value integerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value less than (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)valueIsGreaterThan:(NSNumber *)value {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        NSInteger integerValue;
        
        if ([jsonValue isKindOfClass:[NSNumber class]]) {
            integerValue = [(NSNumber *)jsonValue integerValue];
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSNumber, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (integerValue > [value integerValue]) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires value less than or equal to (%@)", value]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (instancetype)matchesRegularExpression:(NSRegularExpression *)expression {
    
    __weak typeof (self) weakSelf = self;
    ValidatorBlock block = ^BOOL(NSString *jsonKey, id jsonValue) {
        if (![jsonValue isKindOfClass:[NSString class]]) {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Requires NSString, given (%@)", [jsonValue class]]];
            return NO;
        }
        
        if (![expression isKindOfClass:[NSRegularExpression class]]) {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"matchesRegularExpression: called with parameter that must be an NSRegularExpression with value (%@)", jsonValue]];
            return NO;
        }
        
        NSTextCheckingResult *firstMatch = [expression firstMatchInString:jsonValue
                                                                  options:0
                                                                    range:NSMakeRange(0, [jsonValue length])];
        
        if (firstMatch && firstMatch.range.location != NSNotFound) {
            return YES;
        } else {
            [weakSelf.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Must match regular expression (%@)", expression]];
            return NO;
        }
    };
    
    [self.requirements addObject:block];
    
    return self;
}

- (void)validateValue:(id _Nullable)value withKey:(NSString *)key {
    
    if (value) {
        for(ValidatorBlock block in self.requirements) {
            block(key, value);
        }
    } else {
        if (!self.optional) {
            [self.failedRequirementDescriptions addObject:[NSString stringWithFormat:@"Key not found"]];
        }
    }
}

@end


NS_ASSUME_NONNULL_END
