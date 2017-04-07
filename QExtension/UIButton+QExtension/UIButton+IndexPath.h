//
//  UIButton+IndexPath.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (IndexPath)

/// 索引路径
@property (nullable, nonatomic, strong) IBInspectable NSIndexPath *q_indexPath;

@end


NS_ASSUME_NONNULL_END
