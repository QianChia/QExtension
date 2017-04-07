//
//  QChartView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/3/31.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QChartView.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - QChartView

@interface QChartView () <ChartViewDelegate>

@end

@implementation QChartView

#pragma mark horizontal single bar chart view

/// 创建水平单条柱状图
+ (instancetype)q_horizontalSingleBarChartViewWithFrame:(CGRect)frame
                                                 toView:(UIView *)superView
                                               barColor:(UIColor *)barColor
                                        backgroundColor:(UIColor *)backgroundColor
                                            actualValue:(CGFloat)actualValue
                                            targetValue:(CGFloat)targetValue
                                         valueFormatter:(QChartValueFormatter)valueFormatter
                                        animateDuration:(NSTimeInterval)animateDuration {
    
    QChartView *chartView = [[self alloc] init];
    
    id dataValueFormatter = [chartView getChartDataValueFormatterWithValueFormatter:valueFormatter
                                                                  maxValueFormatter:QChartValueNoneFormatter
                                                                  yDataVals:nil];
    
    if (actualValue > targetValue) {
        targetValue = actualValue;
    }
    
    if (superView.subviews.count > 0) {
        [superView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                         NSUInteger idx,
                                                         BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    [chartView drawHorizontalSingleBarChartViewWithFrame:frame
                                                  toView:superView
                                                barColor:barColor
                                         backgroundColor:backgroundColor
                                             actualValue:actualValue
                                             targetValue:targetValue
                                          valueFormatter:dataValueFormatter
                                         animateDuration:animateDuration];
    
    return chartView;
}

/// 绘制水平单条柱状图
- (void)drawHorizontalSingleBarChartViewWithFrame:(CGRect)frame
                                           toView:(UIView *)superView
                                         barColor:(UIColor *)barColor
                                  backgroundColor:(UIColor *)backgroundColor
                                      actualValue:(CGFloat)actualValue
                                      targetValue:(CGFloat)targetValue
                                   valueFormatter:(id <IChartValueFormatter>)valueFormatter
                                  animateDuration:(NSTimeInterval)animateDuration {
    
    // 初始化
    superView.clipsToBounds = YES;
    
    CGFloat height = (frame.size.height >= 12) ? frame.size.height : 12;
    CGRect barFrame = CGRectMake(-10,
                                 -height * 2.0 - 0.5,
                                 frame.size.width + 20,
                                 height + height * 4.0);
    
    HorizontalBarChartView *barChartView = [[HorizontalBarChartView alloc] initWithFrame:barFrame];
    [superView addSubview:barChartView];
    
    // 基本样式
    barChartView.backgroundColor = backgroundColor;
    barChartView.noDataText = @"0";
    barChartView.drawBarShadowEnabled = NO;
    
    if (targetValue != 0) {
        if (actualValue / targetValue < 0.15) {
            barChartView.drawValueAboveBarEnabled = YES;
        } else {
            barChartView.drawValueAboveBarEnabled = NO;
        }
    } else {
        barChartView.drawValueAboveBarEnabled = YES;
    }
    
    // 交互样式
    barChartView.scaleXEnabled = NO;
    barChartView.scaleYEnabled = NO;
    barChartView.doubleTapToZoomEnabled = NO;
    barChartView.dragEnabled = NO;
    
    // X 轴样式
    barChartView.xAxis.enabled = NO;
    
    // Y 轴样式
    barChartView.leftAxis.enabled = NO;
    barChartView.rightAxis.enabled = NO;
    barChartView.leftAxis.axisMinValue = 0;
    
    if ([valueFormatter isKindOfClass:[ChartDataValueIntergerFormatter class]] ||
        [valueFormatter isKindOfClass:[ChartDataValueDoubleFormatter class]]) {
        
        barChartView.leftAxis.axisMaxValue = targetValue;
        
    } else {
        barChartView.leftAxis.axisMaxValue = 100;
    }
    
    // 描述
    barChartView.chartDescription.enabled = NO;
    
    // 图例
    barChartView.legend.enabled = NO;
    
    // 动画效果
    [barChartView animateWithYAxisDuration:animateDuration];
    
    // 表格数据
    NSMutableArray *chartVals1 = [[NSMutableArray alloc] init];
    
    double xValue = 0;
    
    double yValue = 0;
    if ([valueFormatter isKindOfClass:[ChartDataValueIntergerFormatter class]] ||
        [valueFormatter isKindOfClass:[ChartDataValueDoubleFormatter class]]) {
        
        yValue = actualValue;
        
    } else {
        
        if (targetValue != 0) {
            yValue = (actualValue * 100) / targetValue;
        }
    }
    
    BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:xValue y:yValue];
    [chartVals1 addObject:entry];
    
    // 绘制
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:chartVals1 label:nil];
    
    set1.colors = @[barColor];
    if (frame.size.height >= 12) {
        set1.drawValuesEnabled = YES;
    } else {
        set1.drawValuesEnabled = NO;
    }
    set1.highlightEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.f]];
    [data setValueTextColor:[UIColor whiteColor]];
    [data setValueFormatter:valueFormatter];
    
    barChartView.data = data;
}

#pragma mark bar chart view

/// 创建柱状图
+ (instancetype)q_barChartViewWithFrame:(CGRect)frame
                                 toView:(UIView *)superView
                              barColors:(NSArray<UIColor *> *)barColors
                        backgroundColor:(UIColor *)backgroundColor
                                 values:(NSDictionary<NSNumber *, NSNumber *> *)values
                         valueFormatter:(QChartValueFormatter)valueFormatter
                      maxValueFormatter:(QChartValueFormatter)maxValueFormatter
                    xAxisValueFormatter:(QChartValueFormatter)xAxisValueFormatter
                    yAxisValueFormatter:(QChartValueFormatter)yAxisValueFormatter
                        animateDuration:(NSTimeInterval)animateDuration {
    
    QChartView *chartView = [[self alloc] init];
    
    id xAxisFormatter = [chartView getChartAxisValueFormatterWithValueFormatter:xAxisValueFormatter];
    id yAxisFormatter = [chartView getChartAxisValueFormatterWithValueFormatter:yAxisValueFormatter];
    
    NSMutableArray *chartVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < values.count; i++) {
        
        double xValue = values.allKeys[i].doubleValue;
        double yValue = values.allValues[i].doubleValue;
        
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:xValue y:yValue];
        [chartVals addObject:entry];
    }
    
    id dataValueFormatter = [chartView getChartDataValueFormatterWithValueFormatter:valueFormatter
                                                                  maxValueFormatter:maxValueFormatter
                                                                          yDataVals:chartVals];
    
    double maxValue = 0;
    for (int i = 0; i < values.count; i++) {
        if (values.allValues[i].doubleValue > maxValue) {
            maxValue = values.allValues[i].doubleValue;
        }
    }
    maxValue += 20;
    
    if (superView.subviews.count > 0) {
        [superView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj,
                                                         NSUInteger idx,
                                                         BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    [chartView drawBarChartViewWithFrame:frame
                                  toView:superView
                               barColors:barColors
                         backgroundColor:backgroundColor
                                  values:values
                                maxValue:maxValue
                          valueFormatter:dataValueFormatter
                     xAxisValueFormatter:xAxisFormatter
                     yAxisValueFormatter:yAxisFormatter
                         animateDuration:animateDuration];
    
    return chartView;
}

/// 绘制柱状图
- (void)drawBarChartViewWithFrame:(CGRect)frame
                           toView:(UIView *)superView
                        barColors:(NSArray<UIColor *> *)barColors
                  backgroundColor:(UIColor *)backgroundColor
                           values:(NSDictionary<NSNumber *, NSNumber *> *)values
                         maxValue:(CGFloat)maxValue
                   valueFormatter:(id <IChartValueFormatter>)valueFormatter
              xAxisValueFormatter:(id <IChartAxisValueFormatter>)xAxisValueFormatter
              yAxisValueFormatter:(id <IChartAxisValueFormatter>)yAxisValueFormatter
                  animateDuration:(NSTimeInterval)animateDuration {
    
    // 初始化
    BarChartView *barChartView = [[BarChartView alloc] initWithFrame:frame];
    barChartView.delegate = self;
    [superView addSubview:barChartView];
    
    // 基本样式
    barChartView.backgroundColor = backgroundColor;
    barChartView.noDataText = @"No chart data available";
    barChartView.drawValueAboveBarEnabled = YES;
    barChartView.drawBarShadowEnabled = NO;
    
    // 交互样式
    barChartView.scaleXEnabled = NO;
    barChartView.scaleYEnabled = NO;
    barChartView.doubleTapToZoomEnabled = NO;
    barChartView.dragEnabled = YES;
    barChartView.dragDecelerationEnabled = YES;
    barChartView.dragDecelerationFrictionCoef = 0.9;
    
    // X 轴样式
    ChartXAxis *xAxis = barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
    xAxis.axisLineColor = [UIColor blackColor];
    xAxis.valueFormatter = xAxisValueFormatter;
    xAxis.labelTextColor = [UIColor brownColor];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.gridColor = [UIColor clearColor];
    
    // Y 轴样式
    barChartView.rightAxis.enabled = NO;
    ChartYAxis *leftAxis = barChartView.leftAxis;
    leftAxis.inverted = NO;
    leftAxis.axisMinValue = 0;
    leftAxis.axisMaxValue = maxValue;
    leftAxis.axisLineWidth = 1.0 / [UIScreen mainScreen].scale;
    leftAxis.axisLineColor = [UIColor blackColor];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.valueFormatter = yAxisValueFormatter;
    leftAxis.labelTextColor = [UIColor brownColor];
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = NO;
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
    leftAxis.gridAntialiasEnabled = YES;
    
    // 描述
    barChartView.chartDescription.enabled = NO;
    
    // 图例
    barChartView.legend.enabled = NO;
    
    [barChartView animateWithYAxisDuration:animateDuration];
    
    // 表格数据
    NSUInteger vals_count = values.count;
    
    NSMutableArray *chartVals1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < vals_count; i++) {
        
        double xValue = values.allKeys[i].doubleValue;
        double yValue = values.allValues[i].doubleValue;
        
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:xValue y:yValue];
        [chartVals1 addObject:entry];
    }
    
    // 绘制
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:chartVals1 label:nil];
    
    [set1 setColors:ChartColorTemplates.material];
    set1.drawValuesEnabled = YES;
    set1.valueColors = barColors;
    set1.highlightEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    [data setValueTextColor:[UIColor grayColor]];
    [data setValueFormatter:valueFormatter];
    
    barChartView.data = data;
}

- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    
}

#pragma mark value formatter set

/// 获取坐标轴的数据格式
- (id)getChartAxisValueFormatterWithValueFormatter:(QChartValueFormatter)axisFormatter {
    
    id formatter = nil;
    if (axisFormatter == 0) {
        formatter = [[ChartAxisValuePercentFormatter alloc] init];
    } else if (axisFormatter == 1) {
        formatter = [[ChartAxisValueDoubleFormatter alloc] init];
    } else if (axisFormatter == 2) {
        formatter = [[ChartAxisValueIntergerFormatter alloc] init];
    } else {
        formatter = [[ChartAxisValueNoneFormatter alloc] init];
    }
    
    return formatter;
}

/// 获取显示的数据格式
- (id)getChartDataValueFormatterWithValueFormatter:(QChartValueFormatter)valueFormatter
                                 maxValueFormatter:(QChartValueFormatter)maxValueFormatter
                                         yDataVals:(NSArray<ChartDataEntry *> * _Nullable)yVals {
    
    id formatter = nil;
    if (maxValueFormatter != QChartValueNoneFormatter) {
        
        if (maxValueFormatter == 0) {
            formatter = [[ChartMaxDataValuePercentFormatter alloc] initWithYDataVals:yVals];
        } else if (maxValueFormatter == 1) {
            formatter = [[ChartMaxDataValueDoubleFormatter alloc] initWithYDataVals:yVals];
        } else if (maxValueFormatter == 2) {
            formatter = [[ChartMaxDataValueIntergerFormatter alloc] initWithYDataVals:yVals];
        } else {
            formatter = [[ChartMaxDataValueNoneFormatter alloc] initWithYDataVals:yVals];
        }
        
    } else {
        
        if (valueFormatter == 0) {
            formatter = [[ChartDataValuePercentFormatter alloc] init];
        } else if (valueFormatter == 1) {
            formatter = [[ChartDataValueDoubleFormatter alloc] init];
        } else if (valueFormatter == 2) {
            formatter = [[ChartDataValueIntergerFormatter alloc] init];
        } else {
            formatter = [[ChartDataValueNoneFormatter alloc] init];
        }
    }
    
    return formatter;
}

@end


/*******************************************************************************/

#pragma mark - AxisValueFormatter

/**
 *  X/Y 轴 数据格式
 */

/// 百分比型
@interface ChartAxisValuePercentFormatter () <IChartAxisValueFormatter>

@end

@implementation ChartAxisValuePercentFormatter

/// 实现协议方法，返回 x/y 轴的数据，value 为 x/y 轴的值
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return [NSString stringWithFormat:@"%0.0f%%", value];
}

@end

/// 浮点型
@interface ChartAxisValueDoubleFormatter () <IChartAxisValueFormatter>

@end

@implementation ChartAxisValueDoubleFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return [NSString stringWithFormat:@"%0.2f", value];
}

@end

/// 整型
@interface ChartAxisValueIntergerFormatter () <IChartAxisValueFormatter>

@end

@implementation ChartAxisValueIntergerFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return [NSString stringWithFormat:@"%0.0f", value];
}

@end

/// 无类型
@interface ChartAxisValueNoneFormatter () <IChartAxisValueFormatter>

@end

@implementation ChartAxisValueNoneFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    return @"";
}

@end

#pragma mark - DataValueFormatter

/**
 *  柱形上显示的 数据格式
 */

/// 百分比型
@interface ChartDataValuePercentFormatter () <IChartValueFormatter>

@end

@implementation ChartDataValuePercentFormatter

/// 实现协议方法，返回柱形上显示的数据格式
- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    return [NSString stringWithFormat:@"%0.0f%%", entry.y];
}

@end

/// 浮点型
@interface ChartDataValueDoubleFormatter () <IChartValueFormatter>

@end

@implementation ChartDataValueDoubleFormatter

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    return [NSString stringWithFormat:@"%0.2f", entry.y];
}

@end

/// 整型
@interface ChartDataValueIntergerFormatter () <IChartValueFormatter>

@end

@implementation ChartDataValueIntergerFormatter

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    return [NSString stringWithFormat:@"%0.0f", entry.y];
}

@end

/// 无类型
@interface ChartDataValueNoneFormatter () <IChartValueFormatter>

@end

@implementation ChartDataValueNoneFormatter

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    return @"";
}

@end

#pragma mark - MaxDataValueFormatter

/**
 *  柱形上显示的 数据格式，只显示最大值
 */

/// 百分比型
@interface ChartMaxDataValuePercentFormatter () <IChartValueFormatter>

@property (nonatomic, strong) NSArray *yDataValueArray;
@property (nonatomic, assign) double maxDataSetIndex;

@end

@implementation ChartMaxDataValuePercentFormatter

- (instancetype)initWithYDataVals:(NSArray *)yVals {
    
    if (self = [super init]) {
        self.yDataValueArray = yVals;
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:yVals];
        [muArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            ChartDataEntry *entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry *entry2 =(ChartDataEntry *)obj2;
            if (entry1.y >= entry2.y){
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        self.maxDataSetIndex =((ChartDataEntry * )muArr[0]).x;
    }
    return self;
}

/// 实现协议方法，只显示柱形上数据的最大值
- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    if (entry.x == self.maxDataSetIndex) {
        return [NSString stringWithFormat:@"%0.0f%%", entry.y];
    } else {
        return @"";
    }
}

@end

/// 浮点型
@interface ChartMaxDataValueDoubleFormatter () <IChartValueFormatter>

@property (nonatomic, strong) NSArray *yDataValueArray;
@property (nonatomic, assign) double maxDataSetIndex;

@end

@implementation ChartMaxDataValueDoubleFormatter

- (instancetype)initWithYDataVals:(NSArray *)yVals {
    
    if (self = [super init]) {
        self.yDataValueArray = yVals;
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:yVals];
        [muArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            ChartDataEntry *entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry *entry2 =(ChartDataEntry *)obj2;
            if (entry1.y >= entry2.y){
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        self.maxDataSetIndex =((ChartDataEntry * )muArr[0]).x;
    }
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    if (entry.x == self.maxDataSetIndex) {
        return [NSString stringWithFormat:@"%0.2f", entry.y];
    } else {
        return @"";
    }
}

@end

/// 整型
@interface ChartMaxDataValueIntergerFormatter () <IChartValueFormatter>

@property (nonatomic, strong) NSArray *yDataValueArray;
@property (nonatomic, assign) double maxDataSetIndex;

@end

@implementation ChartMaxDataValueIntergerFormatter

- (instancetype)initWithYDataVals:(NSArray *)yVals {
    
    if (self = [super init]) {
        self.yDataValueArray = yVals;
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:yVals];
        [muArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            ChartDataEntry *entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry *entry2 =(ChartDataEntry *)obj2;
            if (entry1.y >= entry2.y){
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        self.maxDataSetIndex =((ChartDataEntry * )muArr[0]).x;
    }
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    if (entry.x == self.maxDataSetIndex) {
        return [NSString stringWithFormat:@"%0.0f", entry.y];
    } else {
        return @"";
    }
}

@end

/// 无类型
@interface ChartMaxDataValueNoneFormatter () <IChartValueFormatter>

@property (nonatomic, strong) NSArray *yDataValueArray;
@property (nonatomic, assign) double maxDataSetIndex;

@end

@implementation ChartMaxDataValueNoneFormatter

- (instancetype)initWithYDataVals:(NSArray *)yVals {
    
    if (self = [super init]) {
        self.yDataValueArray = yVals;
        NSMutableArray *muArr = [NSMutableArray arrayWithArray:yVals];
        [muArr sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
            ChartDataEntry *entry1 =(ChartDataEntry *)obj1;
            ChartDataEntry *entry2 =(ChartDataEntry *)obj2;
            if (entry1.y >= entry2.y){
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        self.maxDataSetIndex =((ChartDataEntry * )muArr[0]).x;
    }
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value
                                entry:(ChartDataEntry * _Nonnull)entry
                         dataSetIndex:(NSInteger)dataSetIndex
                      viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    
    if (entry.x == self.maxDataSetIndex) {
        return @"";
    } else {
        return @"";
    }
}

@end


NS_ASSUME_NONNULL_END
