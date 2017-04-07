//
//  UILabel+AttributedText.h
//  QExtension
//
//  Created by JHQ0228 on 2017/4/3.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UILabel (AttributedText)

/// 富文本字符串数组
@property(nullable, nonatomic, copy) IBInspectable NSArray<NSAttributedString *> *q_attributedStrings NS_AVAILABLE_IOS(6_0);

@end


NS_ASSUME_NONNULL_END
