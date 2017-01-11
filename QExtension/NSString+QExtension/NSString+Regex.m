//
//  NSString+Regex.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "NSString+Regex.h"

NS_ASSUME_NONNULL_BEGIN


@implementation NSString (Regex)

#pragma mark - 正则表达式有效性判断

/// 手机号有效性
- (BOOL)q_isValidMobileNum {
    
    /**
     *  手机号以 13、15、18、170 开头，8 个 \d 数字字符
     *  小灵通 区号：010, 020, 021, 022, 023, 024, 025, 027, 028, 029 还有未设置的新区号xxx
     */
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";
    NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
    
    BOOL ret = [self q_isValidateByRegex:mobileNoRegex];
    BOOL ret1 = [self q_isValidateByRegex:phsRegex];
    
    return (ret || ret1);
}

/// 手机号分服务商
- (BOOL)q_isValidMobileNumClassification {
    
    /**
     *  手机号码
     *  移动：134[0-8], 135, 136, 137, 138, 139, 150, 151, 157, 158, 159, 182, 187, 188, 1705
     *  联通：130, 131, 132, 152, 155, 156, 185, 186, 1709
     *  电信：133, 1349, 153, 180, 189, 1700
     */
    // NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
    /**
     *  中国移动：China Mobile
     *  134[0-8], 135, 136, 137, 138, 139, 150, 151, 157, 158, 159, 182, 187, 188, 1705
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
    
    /**
     *  中国联通：China Unicom
     *  130, 131, 132, 152, 155, 156, 185, 186, 1709
     */
    NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
    
    /**
     *  中国电信：China Telecom
     *  133, 1349, 153, 180, 189, 1700
     */
    NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
    /**
     *  大陆地区固话及小灵通
     *  区号：010, 020, 021, 022, 023, 024, 025, 027, 028, 029
     *  号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    if (([self q_isValidateByRegex:CM]) ||
        ([self q_isValidateByRegex:CU]) ||
        ([self q_isValidateByRegex:CT]) ||
        ([self q_isValidateByRegex:PHS]))
    {
        return YES;
    } else  {
        return NO;
    }
}

/// 邮箱
- (BOOL)q_isValidEmailAddress {
    
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self q_isValidateByRegex:emailRegex];
}

/// 邮编
- (BOOL)q_isValidPostalcode {
    
    NSString *postalRegex = @"^[0-8]\\d{5}(?!\\d)$";
    return [self q_isValidateByRegex:postalRegex];
}

/// 车牌号
- (BOOL)q_isValidCarNum {
    
    // 车牌号：湘K-DE829 香港车牌号码：粤Z-J499港
    // 其中 \u4e00-\u9fa5 表示 unicode 编码中汉字已编码部分，\u9fa5-\u9fff 是保留部分，将来可能会添加
    NSString *carRegex = @"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$";
    return [self q_isValidateByRegex:carRegex];
}

/// 中文
- (BOOL)q_isValidChinese {
    
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    return [self q_isValidateByRegex:chineseRegex];
}

/// Mac 地址
- (BOOL)q_isValidMacAddress {
    
    NSString * macAddRegex = @"([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}";
    return  [self q_isValidateByRegex:macAddRegex];
}

/// Url 地址
- (BOOL)q_isValidUrlAddress {
    
    NSString *regex = @"^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
    return [self q_isValidateByRegex:regex];
}

/// IP 地址
- (BOOL)q_isValidIPAddress {
    
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    BOOL rc = [self q_isValidateByRegex:regex];
    
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

/// 简单的身份证号码有效性检测
- (BOOL)q_isSimpleVerifyIdentityCardNum {
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self q_isValidateByRegex:regex2];
}

/// 精确的身份证号码有效性检测
- (BOOL)q_isAccurateVerifyIdentityCardNum {
    
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    } else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                // 测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            } else {
                
                // 测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if (numberofMatch >0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                // 测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            } else {
                
                // 测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if (numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0, 1)].intValue +
                         [value substringWithRange:NSMakeRange(10, 1)].intValue) * 7 +
                ([value substringWithRange:NSMakeRange(1, 1)].intValue +
                 [value substringWithRange:NSMakeRange(11, 1)].intValue) * 9 +
                ([value substringWithRange:NSMakeRange(2, 1)].intValue +
                 [value substringWithRange:NSMakeRange(12, 1)].intValue) * 10 +
                ([value substringWithRange:NSMakeRange(3, 1)].intValue +
                 [value substringWithRange:NSMakeRange(13, 1)].intValue) * 5 +
                ([value substringWithRange:NSMakeRange(4, 1)].intValue +
                 [value substringWithRange:NSMakeRange(14, 1)].intValue) * 8 +
                ([value substringWithRange:NSMakeRange(5, 1)].intValue +
                 [value substringWithRange:NSMakeRange(15, 1)].intValue) * 4 +
                ([value substringWithRange:NSMakeRange(6, 1)].intValue +
                 [value substringWithRange:NSMakeRange(16, 1)].intValue) * 2 +
                [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 +
                [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 +
                [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                int Y = S % 11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];  // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;                                 // 检测 ID 的校验位
                } else {
                    return NO;
                }
                
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

/// 银行卡号
- (BOOL)q_isValidBankCardNum {
    
    /** 银行卡号有效性问题Luhn算法
     *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
     *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
     *  16 位卡号校验位采用 Luhm 校验方法计算：
     *     1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
     *     2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
     *     3，将加法和加上校验位能被 10 整除。
     */
    
    // 取出最后一位
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];
    
    // 前 15 或 18 位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 前 15 位或者前 18 位倒序存进数组
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    // 奇数位 *2 的积 < 9
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 奇数位 *2 的积 > 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 偶数位数组
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {  // 偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        } else {    // 奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            } else {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0) ? YES : NO;
}

/// 税号
- (BOOL)q_isValidTaxNum {
    
    NSString *taxNoRegex = @"[0-9]\\d{13}([0-9]|X)$";
    return [self q_isValidateByRegex:taxNoRegex];
}

///
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    
    // [\u4e00-\u9fa5A-Za-z0-9_]{4,20}
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    
    NSString *regex = [NSString stringWithFormat:@"%@[%@A-Za-z0-9_]{%d,%d}",
                       first, hanzi, (int)(minLenth-1), (int)(maxLenth-1)];
    return [self q_isValidateByRegex:regex];
}

///
- (BOOL)q_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
                containDigtal:(BOOL)containDigtal
                containLetter:(BOOL)containLetter
        containOtherCharacter:(NSString *)containOtherCharacter
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal {
    
    NSString *hanzi = containChinese ? @"\u4e00-\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)",
                                first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    return [self q_isValidateByRegex:regex];
}

#pragma mark - 助手方法

/**
 *  判断指定字符串是否匹配规则
 *
 *  @param regex
 *
 *  @return 返回是否匹配结果
 */
- (BOOL)q_isValidateByRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end


NS_ASSUME_NONNULL_END
