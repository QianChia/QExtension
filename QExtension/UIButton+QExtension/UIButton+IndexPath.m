//
//  UIButton+IndexPath.m
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UIButton+IndexPath.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN


@implementation UIButton (IndexPath)

const void *indexPathKey = @"indexPathKey";

/// setter
- (void)setQ_indexPath:(NSIndexPath * _Nullable)q_indexPath {
    
    objc_setAssociatedObject(self, indexPathKey, q_indexPath, OBJC_ASSOCIATION_RETAIN);
}

/// getter
- (NSIndexPath * _Nullable)q_indexPath {
    
    return objc_getAssociatedObject(self, indexPathKey);
}

@end


NS_ASSUME_NONNULL_END
