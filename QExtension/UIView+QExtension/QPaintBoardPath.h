//
//  QPaintBoardPath.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/15.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPaintBoardPath : UIBezierPath

/// 线的颜色
@property (nonatomic, strong) UIColor *pathColor;

/// 线的宽度
@property (nonatomic, assign) CGFloat pathWidth;

@end
