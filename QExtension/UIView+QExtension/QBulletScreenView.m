//
//  QBulletScreenView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/21.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QBulletScreenView.h"

NS_ASSUME_NONNULL_BEGIN


#define SELF_WIDTH      self.frame.size.width
#define SELF_HEIGHT     self.frame.size.height


@interface QBulletScreenView ()

/// label
@property (nonatomic, strong) UILabel *contentLabel;

/// 显示图片的视图
@property (nonatomic, strong) UIImageView *imageView;

/// 当前显示的行
@property (nonatomic, assign) NSInteger currentIndex;

/// 文本内容的起始位置、宽度、高度
@property (nonatomic, assign) CGFloat contentX;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

/// 弹幕视图的位置、宽度、高度
@property (nonatomic, assign) CGFloat viewX;
@property (nonatomic, assign) CGFloat viewY;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation QBulletScreenView

/// 创建弹幕视图控件
+ (instancetype)q_bulletScreenWithFrame:(CGRect)frame
                                  texts:(NSArray *)texts
                                  color:(nullable UIColor *)color
                                   font:(nullable UIFont *)font
                                   icon:(nullable UIImage *)icon
                              direction:(QBulletScreenViewDirection)direction
                               duration:(NSTimeInterval)duartion
                                 target:(nullable id<QBulletScreenViewDelegate>)target {
    
    QBulletScreenView *bulletScreenView = [[self alloc] initWithFrame:frame];
    
    bulletScreenView.contentTexts = texts;
    bulletScreenView.contentTextColor = color;
    bulletScreenView.contentTextFont = font;
    bulletScreenView.contentIcon = icon;
    bulletScreenView.animationDirection = direction;
    bulletScreenView.animationDuration = duartion;
    bulletScreenView.delegate = target;
    
    return bulletScreenView;
}

/// 创建视图控件
- (void)setupView {
    
    // 父视图裁剪
    self.clipsToBounds = YES;
    
    // 控件之间的间隔值
    CGFloat margin = 10;
    
    // 判断是否有图标
    if (self.contentIcon) {
        
        // 添加 Icon 视图
        CGRect iconFrame = CGRectMake(margin, 0, SELF_HEIGHT, SELF_HEIGHT);
        self.imageView = [[UIImageView alloc] initWithFrame:iconFrame];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.image = self.contentIcon;
        [self addSubview:self.imageView];
        
        // 计算 Texts 的 frame 值
        self.contentX = margin + SELF_HEIGHT;
        self.contentWidth = SELF_WIDTH - self.contentX - margin;
        
    } else {
        
        // 计算 Texts 的 frame 值
        self.contentX = margin * 2;
        self.contentWidth = SELF_WIDTH - self.contentX - margin;
    }
    self.contentHeight = SELF_HEIGHT;
    self.viewHeight = SELF_HEIGHT;
    
    // 设置默认值
    UIColor *textColor = self.contentTextColor ? : [UIColor redColor];
    UIFont *textFont = self.contentTextFont ? : [UIFont systemFontOfSize:15.0f];
    
    // 创建 label
    CGRect frame1 = CGRectMake(self.contentX, 0, self.contentWidth, self.contentHeight);
    self.contentLabel = [[UILabel alloc] initWithFrame:frame1];
    self.contentLabel.backgroundColor = [UIColor clearColor];
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentLabel.textColor = textColor;
    self.contentLabel.font = textFont;
    self.contentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentClick)];
    [self.contentLabel addGestureRecognizer:tap1];
    [self addSubview:self.contentLabel];
}

/// 开启滚动动画
- (void)startLoopAnimation {
    
    // 控件之间的间隔值
    CGFloat margin = 10;
    
    // 设置默认值
    NSTimeInterval duration = 0;
    
    // 设置第一个 label 显示的内容
    self.contentLabel.text = self.contentTexts[self.currentIndex];
    
    // 滚动时间为 0 时，停止滚动
    if (0 == self.animationDuration) {
        return;
    } else {
        
        // 计算文本内容长度
        CGFloat currentContentWidth = [self.contentLabel.text sizeWithAttributes:@{NSFontAttributeName:(self.contentTextFont ? : [UIFont systemFontOfSize:15.0f])}].width;
        
        CGRect frame = CGRectMake(self.contentX, 0, currentContentWidth, self.contentHeight);
        self.contentLabel.frame = frame;
        
        self.viewWidth = self.contentX + currentContentWidth + margin * 2;
        
        if (self.animationDirection > 1) {  // 左右滚动
            duration = self.animationDuration * currentContentWidth / 150;
        } else {    // 垂直滚动
            duration = self.animationDuration;
        }
    }
    
    CGFloat viewLastStartX = 0;
    CGFloat viewLastEndX = 0;
    
    CGFloat viewLastStartY = 0;
    CGFloat viewLastEndY = 0;
    
    // 判断滚动方向
    switch (self.animationDirection) {
            
        case QBulletScreenViewDirectionUp: {
            
            viewLastStartY = self.superview.bounds.size.height;
            viewLastEndY = -self.viewHeight;
            
            break;
        }
            
        case QBulletScreenViewDirectionDown: {
            
            viewLastStartY = -self.viewHeight;
            viewLastEndY = self.superview.bounds.size.height;
            
            break;
        }
            
        case QBulletScreenViewDirectionLeft: {
            
            viewLastStartX = self.superview.bounds.size.width;
            viewLastEndX = -self.viewWidth;
            
            break;
        }
            
        case QBulletScreenViewDirectionRight: {
            
            viewLastStartX = -self.viewWidth;
            viewLastEndX = self.superview.bounds.size.width;
            
            break;
        }
            
        default:
            break;
    }
    
    self.viewX = self.frame.origin.x;
    self.viewY = self.frame.origin.y;
    
    // 设置开始时的 frame
    CGRect frame1;
    if (self.animationDirection > 1) {
        frame1 = CGRectMake(viewLastStartX, self.viewY, self.viewWidth, self.contentHeight);
    } else {
        frame1 = CGRectMake(self.viewX, viewLastStartY, self.viewWidth, self.contentHeight);
    }
    self.frame = frame1;
    
    // 开始一次滚动动画
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loopAnimationDidStop:finished:context:)];
    
    // 设置结束时的 frame
    CGRect frame2;
    if (self.animationDirection > 1) {
        frame2 = CGRectMake(viewLastEndX, self.viewY, self.viewWidth, self.contentHeight);
    } else {
        frame2 = CGRectMake(self.viewX, viewLastEndY, self.viewWidth, self.contentHeight);
    }
    self.frame = frame2;
    
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

/// 开始滚动
- (void)q_startAnimation {
    
    // 创建视图
    [self setupView];
    
    // 开启动画默认第一条信息
    self.currentIndex = 0;
    
    // 开始滚动动画
    [self startLoopAnimation];
}

/// 文本内容点击事件处理
- (void)contentClick {
    
    if ([self.delegate respondsToSelector:@selector(didClickContentAtIndex:)]) {
        [self.delegate didClickContentAtIndex:self.currentIndex];
    }
}

@end


NS_ASSUME_NONNULL_END
