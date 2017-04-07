//
//  QMacroDefinition.h
//  QExtension
//
//  Created by Haiqian Jia on 2017/4/7.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#ifndef QMacroDefinition_h
#define QMacroDefinition_h

/// screen size

#define Q_SCREEN_WIDTH_FLOAT                            [UIScreen mainScreen].bounds.size.width
#define Q_SCREEN_HEIGHT_FLOAT                           [UIScreen mainScreen].bounds.size.height

#define Q_SCREEN_WIDTH_EQUAL_TO_320                     ([UIScreen mainScreen].bounds.size.width == 320)
#define Q_SCREEN_WIDTH_EQUAL_TO_375                     ([UIScreen mainScreen].bounds.size.width == 375)
#define Q_SCREEN_WIDTH_EQUAL_TO_414                     ([UIScreen mainScreen].bounds.size.width == 414)
#define Q_SCREEN_WIDTH_EQUAL_TO_768                     ([UIScreen mainScreen].bounds.size.width == 768)
#define Q_SCREEN_WIDTH_EQUAL_TO_1024                    ([UIScreen mainScreen].bounds.size.width == 1024)

#define Q_SCREEN_HEIGHT_EQUAL_TO_480                    ([UIScreen mainScreen].bounds.size.height == 480)
#define Q_SCREEN_HEIGHT_EQUAL_TO_568                    ([UIScreen mainScreen].bounds.size.height == 568)
#define Q_SCREEN_HEIGHT_EQUAL_TO_667                    ([UIScreen mainScreen].bounds.size.height == 667)
#define Q_SCREEN_HEIGHT_EQUAL_TO_736                    ([UIScreen mainScreen].bounds.size.height == 736)
#define Q_SCREEN_HEIGHT_EQUAL_TO_1024                   ([UIScreen mainScreen].bounds.size.height == 1024)
#define Q_SCREEN_HEIGHT_EQUAL_TO_1366                   ([UIScreen mainScreen].bounds.size.height == 1366)

#define	Q_SCREEN_INCH_EQUAL_TO_35                       CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size)
#define	Q_SCREEN_INCH_EQUAL_TO_40                       CGSizeEqualToSize(CGSizeMake(640, 1136), [UIScreen mainScreen].currentMode.size)
#define	Q_SCREEN_INCH_EQUAL_TO_47                       CGSizeEqualToSize(CGSizeMake(750, 1334), [UIScreen mainScreen].currentMode.size)
#define	Q_SCREEN_INCH_EQUAL_TO_55                       CGSizeEqualToSize(CGSizeMake(1242, 2208), [UIScreen mainScreen].currentMode.size)

/// system version

#define Q_SYS_VERSION_FLOAT                             [UIDevice currentDevice].systemVersion.floatValue
#define Q_SYS_VERSION_STRING                            [UIDevice currentDevice].systemVersion

#define Q_SYS_VERSION_GREATER_THAN_80                   ([UIDevice currentDevice].systemVersion.floatValue > 8.0)
#define Q_SYS_VERSION_GREATER_THAN_81                   ([UIDevice currentDevice].systemVersion.floatValue > 8.1)
#define Q_SYS_VERSION_GREATER_THAN_82                   ([UIDevice currentDevice].systemVersion.floatValue > 8.2)
#define Q_SYS_VERSION_GREATER_THAN_83                   ([UIDevice currentDevice].systemVersion.floatValue > 8.3)
#define Q_SYS_VERSION_GREATER_THAN_84                   ([UIDevice currentDevice].systemVersion.floatValue > 8.4)
#define Q_SYS_VERSION_GREATER_THAN_90                   ([UIDevice currentDevice].systemVersion.floatValue > 9.0)
#define Q_SYS_VERSION_GREATER_THAN_91                   ([UIDevice currentDevice].systemVersion.floatValue > 9.1)
#define Q_SYS_VERSION_GREATER_THAN_92                   ([UIDevice currentDevice].systemVersion.floatValue > 9.2)
#define Q_SYS_VERSION_GREATER_THAN_93                   ([UIDevice currentDevice].systemVersion.floatValue > 9.3)
#define Q_SYS_VERSION_GREATER_THAN_100                  ([UIDevice currentDevice].systemVersion.floatValue > 10.0)
#define Q_SYS_VERSION_GREATER_THAN_101                  ([UIDevice currentDevice].systemVersion.floatValue > 10.1)
#define Q_SYS_VERSION_GREATER_THAN_102                  ([UIDevice currentDevice].systemVersion.floatValue > 10.2)
#define Q_SYS_VERSION_GREATER_THAN_103                  ([UIDevice currentDevice].systemVersion.floatValue > 10.3)

#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_80       ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_81       ([UIDevice currentDevice].systemVersion.floatValue >= 8.1)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_82       ([UIDevice currentDevice].systemVersion.floatValue >= 8.2)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_83       ([UIDevice currentDevice].systemVersion.floatValue >= 8.3)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_84       ([UIDevice currentDevice].systemVersion.floatValue >= 8.4)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_90       ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_91       ([UIDevice currentDevice].systemVersion.floatValue >= 9.1)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_92       ([UIDevice currentDevice].systemVersion.floatValue >= 9.2)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_93       ([UIDevice currentDevice].systemVersion.floatValue >= 9.3)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_100      ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_101      ([UIDevice currentDevice].systemVersion.floatValue >= 10.1)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_102      ([UIDevice currentDevice].systemVersion.floatValue >= 10.2)
#define Q_SYS_VERSION_GREATER_THAN_OR_EQUAL_TO_103      ([UIDevice currentDevice].systemVersion.floatValue >= 10.3)

/// device info

#define Q_DEVICE_NAME                                   [UIDevice currentDevice].name
#define Q_DEVICE_UUID_STRING                            [UIDevice currentDevice].identifierForVendor.UUIDString
#define Q_DEVICE_LANGUAGE                               [NSLocale preferredLanguages].firstObject

#define Q_DEVICE_IS_IPHONE                              ([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
#define Q_DEVICE_IS_IPAD                                ([[UIDevice currentDevice].model isEqualToString:@"iPad"])
#define Q_DEVICE_IS_IPOD                                ([[UIDevice currentDevice].model isEqualToString:@"iPod touch"])

#define Q_DEVICE_IS_IPHONE_4                            (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_480)
#define Q_DEVICE_IS_IPHONE_4S                           (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_480)
#define Q_DEVICE_IS_IPHONE_5                            (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_568)
#define Q_DEVICE_IS_IPHONE_5S                           (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_568)
#define Q_DEVICE_IS_IPHONE_5C                           (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_568)
#define Q_DEVICE_IS_IPHONE_6                            (Q_SCREEN_WIDTH_EQUAL_TO_375 && Q_SCREEN_HEIGHT_EQUAL_TO_667)
#define Q_DEVICE_IS_IPHONE_6S                           (Q_SCREEN_WIDTH_EQUAL_TO_375 && Q_SCREEN_HEIGHT_EQUAL_TO_667)
#define Q_DEVICE_IS_IPHONE_6P                           (Q_SCREEN_WIDTH_EQUAL_TO_414 && Q_SCREEN_HEIGHT_EQUAL_TO_736)
#define Q_DEVICE_IS_IPHONE_6SP                          (Q_SCREEN_WIDTH_EQUAL_TO_414 && Q_SCREEN_HEIGHT_EQUAL_TO_736)
#define Q_DEVICE_IS_IPHONE_7                            (Q_SCREEN_WIDTH_EQUAL_TO_375 && Q_SCREEN_HEIGHT_EQUAL_TO_667)
#define Q_DEVICE_IS_IPHONE_7P                           (Q_SCREEN_WIDTH_EQUAL_TO_414 && Q_SCREEN_HEIGHT_EQUAL_TO_736)
#define Q_DEVICE_IS_IPHONE_SE                           (Q_SCREEN_WIDTH_EQUAL_TO_320 && Q_SCREEN_HEIGHT_EQUAL_TO_568)

#define Q_DEVICE_IS_LANDSCAPE                           ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || \
                                                         [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight)
#define Q_DEVICE_IS_PORTRAIT                            ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || \
                                                         [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

/// APP

#define Q_APP_NAME                                      [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]
#define Q_APP_VERSION_STRING                            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/// color

#define Q_COLOR_BLACK                                   [UIColor blackColor]
#define Q_COLOR_DARKGRAY                                [UIColor darkGrayColor]
#define Q_COLOR_LIGHTGRAY                               [UIColor lightGrayColor]
#define Q_COLOR_WHITE                                   [UIColor whiteColor]
#define Q_COLOR_GRAY                                    [UIColor grayColor]
#define Q_COLOR_RED                                     [UIColor redColor]
#define Q_COLOR_GREEN                                   [UIColor greenColor]
#define Q_COLOR_BLUE                                    [UIColor blueColor]
#define Q_COLOR_CYAN                                    [UIColor cyanColor]
#define Q_COLOR_YELLOW                                  [UIColor yellowColor]
#define Q_COLOR_MAGENTA                                 [UIColor magentaColor]
#define Q_COLOR_ORANGE                                  [UIColor orangeColor]
#define Q_COLOR_PURPLE                                  [UIColor purpleColor]
#define Q_COLOR_BROWN                                   [UIColor brownColor]
#define Q_COLOR_CLEAR                                   [UIColor clearColor]

#define Q_COLOR_RANDOM                                  [UIColor colorWithRed:arc4random_uniform(256)/255.0  \
                                                                        green:arc4random_uniform(256)/255.0  \
                                                                         blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define Q_COLOR_RGB(r, g, b)                            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define Q_COLOR_RGBA(r, g, b, a)                        [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:(a)]
#define Q_COLOR_RGBI(s)                                 [UIColor colorWithRed:((s>>16)&0xff)/255.0 green:((s>>8)&0xff)/255.0 blue:(s&0xff)/255.0 alpha:1.0]



#endif /* QMacroDefinition_h */
