//
//  UILabel+AttributedText.m
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "UILabel+AttributedText.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN


@implementation UILabel (AttributedText)

const void *attributedStringsKey = @"attributedStringsKey";

/// setter
- (void)setQ_attributedStrings:(NSArray<NSAttributedString *> * _Nullable)q_attributedStrings {
    
    objc_setAssociatedObject(self, attributedStringsKey, q_attributedStrings, OBJC_ASSOCIATION_RETAIN);
    
    if (!q_attributedStrings || q_attributedStrings.count == 0) {
        
        self.attributedText = [[NSAttributedString alloc] init];
        
    } else {
        
        NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] init];
        for (NSAttributedString *s in q_attributedStrings) {
            [strM appendAttributedString:s];
        }
        
        self.attributedText = strM;
    }
}

/// getter
- (NSArray<NSAttributedString *> * _Nullable)q_attributedStrings {
    return objc_getAssociatedObject(self, attributedStringsKey);
}

@end


NS_ASSUME_NONNULL_END
