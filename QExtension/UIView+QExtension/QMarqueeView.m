//
//  QMarqueeView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/20.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QMarqueeView.h"

NS_ASSUME_NONNULL_BEGIN


@interface QMarqueeView ()

/// 两个 label 循环滚动
@property (nonatomic, strong) UILabel *firstContentLabel;
@property (nonatomic, strong) UILabel *secondContentLabel;

/// 显示图片的视图
@property (nonatomic, strong) UIImageView *imageView;

/// 当前显示的行
@property (nonatomic, assign) NSInteger currentIndex;

/// 文本内容的宽度高度
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

/// 文本内容的起始位置
@property (nonatomic, assign) CGFloat contentX;

@end

@implementation QMarqueeView

/// 创建跑马灯对象，开始滚动
+ (instancetype)q_marqueeViewWithFrame:(CGRect)frame
                                 texts:(NSArray *)texts
                                 color:(nullable UIColor *)color
                                  font:(nullable UIFont *)font
                                 image:(nullable UIImage *)image
                              duration:(NSTimeInterval)duartion
                             direction:(QMarqueeViewDirection)direction
                                 align:(NSTextAlignment)align
                                target:(id<QMarqueeViewDelegate>)target {
    
    QMarqueeView *marqueeView = [[self alloc] initWithFrame:frame];
    
    marqueeView.contentTexts = texts;
    marqueeView.contentTextColor = color;
    marqueeView.contentTextFont = font;
    marqueeView.contentImage = image;
    marqueeView.animationDuration = duartion;
    marqueeView.animationDirection = direction;
    marqueeView.contentTextAlign = align;
    marqueeView.delegate = target;
    
    [marqueeView q_startAnimation];
    
    return marqueeView;
}

/// 设置视图控件
- (void)setupView {
    
    // 判断是否有图片
    if (self.contentImage) {
        
        CGRect frame = CGRectMake(10, 0, self.frame.size.height, self.frame.size.height);
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.image = self.contentImage;
        [self addSubview:self.imageView];
        
        self.contentX = 10 + self.frame.size.height + 10;
        self.contentWidth = self.frame.size.width - self.contentX - 10;
        
    } else {
        
        self.contentX = 10;
        self.contentWidth = self.frame.size.width - self.contentX - 10;
    }
    self.contentHeight = self.frame.size.height;
    
    // 创建第一个 label
    CGRect frame1 = CGRectMake(self.contentX, 0, self.contentWidth, self.contentHeight);
    self.firstContentLabel = [[UILabel alloc] initWithFrame:frame1];
    self.firstContentLabel.backgroundColor = [UIColor clearColor];
    self.firstContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.firstContentLabel.textColor = self.contentTextColor ? : [UIColor redColor];
    self.firstContentLabel.font = self.contentTextFont ? : [UIFont systemFontOfSize:15.0f];
    self.firstContentLabel.textAlignment = self.contentTextAlign ? : NSTextAlignmentLeft;
    self.firstContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(tapContentClick)];
    [self.firstContentLabel addGestureRecognizer:tap1];
    [self addSubview:self.firstContentLabel];
    
    // 创建第二个 label
    CGRect frame2 = CGRectMake(self.contentX, self.frame.size.height, self.contentWidth, self.contentHeight);
    self.secondContentLabel = [[UILabel alloc] initWithFrame:frame2];
    self.secondContentLabel.backgroundColor = [UIColor clearColor];
    self.secondContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.secondContentLabel.textColor = self.contentTextColor ? : [UIColor redColor];
    self.secondContentLabel.font = self.contentTextFont ? : [UIFont systemFontOfSize:15.0f];
    self.secondContentLabel.textAlignment = self.contentTextAlign ? : NSTextAlignmentLeft;
    self.secondContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(tapContentClick)];
    [self.secondContentLabel addGestureRecognizer:tap2];
    [self addSubview:self.secondContentLabel];
    
    // 父视图裁剪
    self.clipsToBounds = YES;
}

/// 开启滚动动画
- (void)startLoopAnimation {
    
    NSTimeInterval delay = 0;
    
    // 设置第一个 label 显示的内容
    self.firstContentLabel.text = [self.contentTexts objectAtIndex:self.currentIndex];
    
    // 滚动时间为 0 时，停止滚动
    if (0 == self.animationDuration) {
        return;
    } else {
        if (self.animationDirection > 1) {
            delay = 0;
        } else {
            delay = self.animationDelay ? : 1.0f;
        }
    }
    
    CGFloat firstContentLastStartX = 0;
    CGFloat firstContentLastEndX = 0;
    
    CGFloat firstContentLastStartY = 0;
    CGFloat firstContentLastEndY = 0;
    CGFloat secondContentLastStartY = 0;
    CGFloat secondContentLastEndY = 0;
    
    NSInteger secondCurrentIndex  = self.currentIndex + 1;
    if (secondCurrentIndex > self.contentTexts.count - 1) {
        secondCurrentIndex = 0;
    }
    
    // 判断滚动方向
    switch (self.animationDirection) {
            
        case QMarqueeViewDirectionUp: {
            
            firstContentLastStartY = 0;
            firstContentLastEndY = -self.frame.size.height;
            
            secondContentLastStartY = firstContentLastStartY + self.frame.size.height;
            secondContentLastEndY = firstContentLastEndY + self.frame.size.height;
            
            break;
        }
        
        case QMarqueeViewDirectionDown: {
            
            firstContentLastStartY = 0;
            firstContentLastEndY = self.frame.size.height;
            
            secondContentLastStartY = firstContentLastStartY - self.frame.size.height;
            secondContentLastEndY = firstContentLastEndY - self.frame.size.height;
            
            break;
        }
        
        case QMarqueeViewDirectionLeft: {
            
            CGFloat currentContentWidth = [self.firstContentLabel.text sizeWithAttributes:@{NSFontAttributeName:self.contentTextFont}].width;
            
            firstContentLastStartX = self.contentX + self.contentWidth;
            firstContentLastEndX =  -currentContentWidth;
            
            break;
        }
        
        case QMarqueeViewDirectionRight: {
            
            break;
        }
        
        default:
            break;
    }
    
    // 设置第二个 label 显示的内容
    self.secondContentLabel.text = [self.contentTexts objectAtIndex:secondCurrentIndex];
    
    CGRect frame1;
    CGRect frame2;
    if (self.animationDirection > 1) {
        frame1 = CGRectMake(firstContentLastStartX, 0, self.contentWidth, self.contentHeight);
    } else {
        frame1 = CGRectMake(self.contentX, firstContentLastStartY, self.contentWidth, self.contentHeight);
        frame2 = CGRectMake(self.contentX, secondContentLastStartY, self.contentWidth, self.contentHeight);
    }
    self.firstContentLabel.frame = frame1;
    self.secondContentLabel.frame = frame2;
    
    // 开始一次滚动动画
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:(self.animationDuration)];
    [UIView setAnimationDelay:delay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loopAnimationDidStop:finished:context:)];
    
    CGRect frame3;
    CGRect frame4;
    if (self.animationDirection > 1) {
        frame3 = CGRectMake(firstContentLastEndX, 0, self.contentWidth, self.contentHeight);
    } else {
        frame3 = CGRectMake(self.contentX, firstContentLastEndY, self.contentWidth, self.contentHeight);
        frame4 = CGRectMake(self.contentX, secondContentLastEndY, self.contentWidth, self.contentHeight);
    }
    self.firstContentLabel.frame = frame3;
    self.secondContentLabel.frame = frame4;
    
    // 结束一次滚动动画
    [UIView commitAnimations];
}

/// 一次动画结束事件响应处理
- (void)loopAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    self.currentIndex++;
    if (self.currentIndex >= self.contentTexts.count) {
        self.currentIndex = 0;
    }
    
    // 重新开启滚动动画
    [self startLoopAnimation];
}

/// 文本内容点击事件处理
- (void)tapContentClick {
    
    if ([self.delegate respondsToSelector:@selector(didClickContentAtIndex:)]) {
        [self.delegate didClickContentAtIndex:self.currentIndex];
    }
}

/// 开始滚动
- (void)q_startAnimation {
    
    // 创建视图
    [self setupView];
    
    // 开启动画默认第一条信息
    self.currentIndex = 0;
    
    // 开始滚动动画
    [self startLoopAnimation];
}

@end


NS_ASSUME_NONNULL_END
