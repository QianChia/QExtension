//
//  QExtension.h
//  QExtension
//
//  Created by JHQ0228 on 16/7/18.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//  GitHub https://github.com/QianChia
//  Blog   http://www.cnblogs.com/QianChia/
//

/**
 *  添加 QChartView 方法
 *
 *  1、在 TARGET => General => Embedded Binaries 中添加 Charts.framework
 *  2、将 TARGET => Build Settings => Build Options => Always Embed Swift Standard Libraries 设置为 YES
 *  3、在使用的地方添加头文件 QChartView.h，使用 QChartView 中定义的方法，或者 Charts 框架中的方法即可
 *
 *
 *  Add QChartView method
 *
 *  1、In TARGET = > General = > Embedded Binaries add Charts.framework
 *  2、Will TARGET => Build Settings => Build Options => Always Embed Swift Standard Libraries set to YES
 *  3、Add QChartView.h header file where use QChartView, use the methods defined in QChartView, or Charts framework of the method
 */

#ifndef QExtension_h
#define QExtension_h

// Macro

#import "QMacroDefinition.h"

// Foundation

#import "NSArray+QExtension.h"

#import "NSData+QExtension.h"

#import "NSDate+QExtension.h"

#import "NSDictionary+QExtension.h"

#import "NSString+QExtension.h"

#import "NSObject+QExtension.h"

// UIKit

#import "UIButton+QExtension.h"

#import "UIColor+QExtension.h"

#import "UIImage+QExtension.h"

#import "UILabel+QExtension.h"

#import "UIView+QExtension.h"

#import "UIViewController+QExtension.h"


#endif /* QExtension_h */
