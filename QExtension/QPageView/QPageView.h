//
//  QPageView.h
//  QExtensionExample
//
//  Created by JHQ0228 on 16/9/10.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 页码视图位置枚举
typedef NS_ENUM(NSInteger, QPageIndicatorPosition) {
    
    Left          = 0,
    Center        = 1,    // default
    Right         = 2,
    LeftCenter    = 3,
    RightCenter   = 4,
};

@interface QPageView : UIView

/// 显示的图片名字
@property (nonatomic, strong) NSArray<NSString *> *imageNames;

/// 页码视图位置
@property(nonatomic)QPageIndicatorPosition pageIndicatorPosition;

/// 当前页面指示器颜色，default is whiteColor
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;

/// 其他页面指示器颜色，default is grayColor
@property (nonatomic, strong) UIColor *pageIndicatorColor;

/// 是否隐藏页面指示器，default is NO
@property(nonatomic, assign, getter=isHidePageIndicator) BOOL hidePageIndicator;

/// 是否竖屏滚动，default is NO
@property(nonatomic, assign, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;

/**
 *  实例化页面视图控件
 */
+ (instancetype)pageView;

/**
 *  实例化页面视图控件
 *
 *  @param imageNames 显示的图片名字
 *  @param autoScroll 是否自动滚动，default is YES
 *  @param time       自动滚动时间间隔，default is 2.0
 *  @param position   页码视图位置，default is Center
 */
+ (instancetype)pageViewWithImageNames:(NSArray<NSString *> *)imageNames
                            autoScroll:(BOOL)autoScroll
                        autoScrollTime:(NSTimeInterval)time
                 pageIndicatorPosition:(QPageIndicatorPosition)position;

@end
