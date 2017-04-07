//
//  QPageView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 页码视图位置枚举
typedef NS_ENUM(NSInteger, QPageIndicatorPosition) {
    
    QPageIndicatorPositionLeft          = 0,
    QPageIndicatorPositionCenter        = 1,    // default
    QPageIndicatorPositionRight         = 2,
    QPageIndicatorPositionLeftCenter    = 3,
    QPageIndicatorPositionRightCenter   = 4,
};

@interface QPageView : UIView

/// 显示的图片名字
@property (nonatomic, strong) IBInspectable NSArray<NSString *> *imageNames;

/// 页码视图位置
@property(nonatomic) IBInspectable QPageIndicatorPosition pageIndicatorPosition;

/// 当前页面指示器颜色，default is whiteColor
@property (nonatomic, strong) IBInspectable UIColor *currentPageIndicatorColor;

/// 其他页面指示器颜色，default is grayColor
@property (nonatomic, strong) IBInspectable UIColor *pageIndicatorColor;

/// 是否隐藏页面指示器，default is NO
@property(nonatomic, assign, getter=isHidePageIndicator) IBInspectable BOOL hidePageIndicator;

/// 是否竖屏滚动，default is NO
@property(nonatomic, assign, getter=isScrollDirectionPortrait) IBInspectable BOOL scrollDirectionPortrait;

/**
 *  创建分页视图控件
 *
 *  @param frame        页面视图控件的 frame
 *  @param imageNames   显示的图片名字
 *  @param autoScroll   是否自动滚动，default is YES
 *  @param time         自动滚动时间间隔，default is 2.0
 *  @param position     页码视图位置，default is Center
 */
+ (instancetype)q_pageViewWithFrame:(CGRect)frame
                         imageNames:(nullable NSArray<NSString *> *)imageNames
                         autoScroll:(BOOL)autoScroll
                     autoScrollTime:(NSTimeInterval)time
              pageIndicatorPosition:(QPageIndicatorPosition)position;

@end


NS_ASSUME_NONNULL_END
