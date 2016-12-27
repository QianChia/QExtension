//
//  NSString+Regex.h
//  QExtension
//
//  Created by JHQ0228 on 2016/12/27.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

#pragma mark - 正则表达式有效性判断

/// 手机号有效性
- (BOOL)q_isValidMobileNum;

/// 手机号分服务商
- (BOOL)q_isValidMobileNumClassification;

/// 邮箱
- (BOOL)q_isValidEmailAddress;

/// 邮编
- (BOOL)q_isValidPostalcode;

/// 车牌号
- (BOOL)q_isValidCarNum;

/// 中文
- (BOOL)q_isValidChinese;

/// Mac 地址
- (BOOL)q_isValidMacAddress;

/// Url 地址
- (BOOL)q_isValidUrlAddress;

/// IP 地址
- (BOOL)q_isValidIPAddress;

/// 简单的身份证号码有效性检测
- (BOOL)q_isSimpleVerifyIdentityCardNum;

/// 精确的身份证号码有效性检测
- (BOOL)q_isAccurateVerifyIdentityCardNum;

/// 银行卡号
- (BOOL)q_isValidBankCardNum;

/// 税号
- (BOOL)q_isValidTaxNum;

///
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

///
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
                containDigtal:(BOOL)containDigtal
                containLetter:(BOOL)containLetter
        containOtherCharacter:(NSString *)containOtherCharacter
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

@end
