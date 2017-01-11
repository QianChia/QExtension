//
//  NSDictionary+LocaleLog.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDictionary (LocaleLog)

/**
 *  本地化打印输出
 *
 *  Xcode 没有针对国际化语言做特殊处理，直接 Log 数组，只打印 UTF8 的编码，不能显示中文。
 *
 *  - (NSString *)descriptionWithLocale:(nullable id)locale;
 *
 *  重写这个方法，就能够解决输出问题，这个方法是专门为了本地话提供的一个调试方法，只要重写，
 *  不需要导入头文件，程序中所有的 NSLog 数组的方法，都会被替代。
 */

@end


NS_ASSUME_NONNULL_END
