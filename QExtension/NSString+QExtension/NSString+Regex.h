//
//  NSString+Regex.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Regex)

/**
 *  手机号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidMobileNum;

/**
 *  手机号分服务商有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidMobileNumClassification;

/**
 *  邮箱有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidEmailAddress;

/**
 *  邮编有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidPostalcode;

/**
 *  车牌号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidCarNum;

/**
 *  中文有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidChinese;

/**
 *  Mac 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidMacAddress;

/**
 *  Url 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidUrlAddress;

/**
 *  IP 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidIPAddress;

/**
 *  简单的身份证号码有效性检测
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isSimpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isAccurateVerifyIdentityCardNum;

/**
 *  银行卡号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidBankCardNum;

/**
 *  税号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidTaxNum;

/**
 *  有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 *  有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
                containDigtal:(BOOL)containDigtal
                containLetter:(BOOL)containLetter
        containOtherCharacter:(NSString *)containOtherCharacter
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

@end


NS_ASSUME_NONNULL_END
