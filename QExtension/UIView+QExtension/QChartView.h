//
//  QChartView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/3/31.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
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

#import <UIKit/UIKit.h>

#import <Charts/Charts-Swift.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QChartView

/// 数据类型枚举
typedef NS_ENUM(NSUInteger, QChartValueFormatter) {
    QChartValuePercentFormatter = 0,    // 百分型
    QChartValueDoubleFormatter,         // 浮点型
    QChartValueIntegerFormatter,        // 整型
    QChartValueNoneFormatter            // 无类型
};

@interface QChartView : UIView

/**
 *  创建水平单条柱状图
 *
 *  @param frame            SingleBarChart 的 frame，x y 设置无效
 *  @param superView        SingleBarChart 的父视图
 *  @param barColor         SingleBarChart 的颜色
 *  @param backgroundColor  SingleBarChart 的背景颜色
 *  @param actualValue      实际值
 *  @param targetValue      目标值
 *  @param valueFormatter   显示的数据格式
 *  @param animateDuration  动画时间
 *
 *  @return 跑马灯视图控件
 */
+ (instancetype)q_horizontalSingleBarChartViewWithFrame:(CGRect)frame
                                                 toView:(UIView *)superView
                                               barColor:(UIColor *)barColor
                                        backgroundColor:(UIColor *)backgroundColor
                                            actualValue:(CGFloat)actualValue
                                            targetValue:(CGFloat)targetValue
                                         valueFormatter:(QChartValueFormatter)valueFormatter
                                        animateDuration:(NSTimeInterval)animateDuration;

/**
 *  创建柱状图
 *
 *  @param frame                柱状图的 frame
 *  @param superView            柱状图的父视图
 *  @param barColors            柱状图的颜色值数组
 *  @param backgroundColor      柱状图的背景颜色
 *  @param values               柱状图的数据源数组
 *  @param valueFormatter       显示的数据格式
 *  @param maxValueFormatter    显示最大值的数据格式
 *  @param xAxisValueFormatter  x 轴的数据格式
 *  @param yAxisValueFormatter  y 轴的数据格式
 *  @param animateDuration      动画时间
 *
 *  @return 跑马灯视图控件
 */
+ (instancetype)q_barChartViewWithFrame:(CGRect)frame
                                 toView:(UIView *)superView
                              barColors:(NSArray<UIColor *> *)barColors
                        backgroundColor:(UIColor *)backgroundColor
                                 values:(NSDictionary<NSNumber *, NSNumber *> *)values
                         valueFormatter:(QChartValueFormatter)valueFormatter
                      maxValueFormatter:(QChartValueFormatter)maxValueFormatter
                    xAxisValueFormatter:(QChartValueFormatter)xAxisValueFormatter
                    yAxisValueFormatter:(QChartValueFormatter)yAxisValueFormatter
                        animateDuration:(NSTimeInterval)animateDuration;

@end


/*******************************************************************************/

#pragma mark - AxisValueFormatter

/**
 *  X/Y 轴 数据格式
 */

/// 百分比型
@interface ChartAxisValuePercentFormatter : NSObject

@end

/// 浮点型
@interface ChartAxisValueDoubleFormatter : NSObject

@end

/// 整型
@interface ChartAxisValueIntergerFormatter : NSObject

@end

/// 无类型
@interface ChartAxisValueNoneFormatter : NSObject

@end

#pragma mark - DataValueFormatter

/**
 *  柱形上显示的 数据格式
 */

/// 百分比型
@interface ChartDataValuePercentFormatter : NSObject

@end

/// 浮点型
@interface ChartDataValueDoubleFormatter : NSObject

@end

/// 整型
@interface ChartDataValueIntergerFormatter : NSObject

@end

/// 无类型
@interface ChartDataValueNoneFormatter : NSObject

@end

#pragma mark - MaxDataValueFormatter

/**
 *  柱形上显示的 数据格式，只显示最大值
 */

/// 百分比型
@interface ChartMaxDataValuePercentFormatter : NSObject

- (instancetype)initWithYDataVals:(NSArray *)yVals;

@end

/// 浮点型
@interface ChartMaxDataValueDoubleFormatter : NSObject

- (instancetype)initWithYDataVals:(NSArray *)yVals;

@end

/// 整型
@interface ChartMaxDataValueIntergerFormatter : NSObject

- (instancetype)initWithYDataVals:(NSArray *)yVals;

@end

/// 无类型
@interface ChartMaxDataValueNoneFormatter : NSObject

- (instancetype)initWithYDataVals:(NSArray *)yVals;

@end


NS_ASSUME_NONNULL_END
