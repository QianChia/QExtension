//
//  UIButton+Progress.m
//  QExtension
//
//  Created by JHQ0228 on 16/7/12.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "UIButton+Progress.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIButton (Progress)

/// 进度
float _progress;

/// 线宽
CGFloat _lineWidth;

/// 线颜色
UIColor *_lineColor;

/// 设置属性

- (void)q_setButtonWithProgress:(float)progress
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(nullable UIColor *)lineColor
                backgroundColor:(nullable UIColor *)backgroundColor {

    _progress = progress;
    _lineWidth = lineWidth ? : 2;
    _lineColor = lineColor ? : [UIColor orangeColor];
    
    self.layer.cornerRadius = MIN(self.bounds.size.width, self.bounds.size.height) * 0.5;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = backgroundColor ? : [UIColor clearColor];
    
    [self setTitle:[NSString stringWithFormat:@"%.0f%%", progress * 100] forState:UIControlStateNormal];
    
    [self setNeedsDisplay];
}

/// 核心绘图

- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat r = (MIN(rect.size.width, rect.size.height) - _lineWidth) * 0.5;
    CGFloat start = - M_PI_2;
    CGFloat end = _progress * 2 * M_PI + start;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:r startAngle:start endAngle:end clockwise:YES];
    
    path.lineWidth = _lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    
    [_lineColor setStroke];
    
    [path stroke];
}

@end


NS_ASSUME_NONNULL_END
