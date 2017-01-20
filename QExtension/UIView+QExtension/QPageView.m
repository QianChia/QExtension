//
//  QPageView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QPageView.h"

NS_ASSUME_NONNULL_BEGIN


static int const ImageViewCount = 3;

@interface QPageView() <UIScrollViewDelegate>

/// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;

/// 页码视图
@property (nonatomic, strong) UIPageControl *pageControl;

/// 定时器
@property (nullable, nonatomic, strong) NSTimer *timer;

/// 是否自动滚动，default is YES
@property(nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;

/// 自动滚动时间间隔，default is 2.0
@property (nonatomic, assign) NSTimeInterval autoScrollTime;

@end

@implementation QPageView

/// 创建分页视图控件
+ (instancetype)q_pageViewWithFrame:(CGRect)frame
                         imageNames:(nullable NSArray<NSString *> *)imageNames
                         autoScroll:(BOOL)autoScroll
                     autoScrollTime:(NSTimeInterval)time
              pageIndicatorPosition:(QPageIndicatorPosition)position {
    
    QPageView *pageView = [[self alloc] init];
    
    pageView.frame = frame;
    pageView.imageNames = imageNames;
    pageView.autoScroll = autoScroll;
    pageView.autoScrollTime = time;
    pageView.pageIndicatorPosition = position;
    
    return pageView;
}

/// 初始化控件
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 滚动视图
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        // 图片控件
        for (int i = 0; i < ImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self.scrollView addSubview:imageView];
        }
        
        // 页码视图
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];
        
        // 设置默认值
        self.autoScrollTime = 2.0;
        self.autoScroll = YES;
        self.scrollDirectionPortrait = NO;
        self.hidePageIndicator = NO;
        self.pageIndicatorPosition = QPageIndicatorPositionCenter;
    }
    return self;
}

/// 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置滚动视图的 frame
    self.scrollView.frame = self.bounds;
    
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    // 设置滚动视图的偏移量（首先显示的视图）
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, scrollH);
    } else {
        self.scrollView.contentOffset = CGPointMake(scrollW, 0);
    }
    
    // 设置页码视图位置
    
    CGFloat margin = 5;
    
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = (scrollW - pageW) / 2;
    CGFloat pageY = scrollH - pageH;
    
    if (self.pageIndicatorPosition == QPageIndicatorPositionLeft) {
        
        pageX = margin;
        pageY = scrollH - pageH - margin;
        
    } else if (self.pageIndicatorPosition == QPageIndicatorPositionCenter) {
        
        pageY = scrollH - pageH - margin;
        
    } else if (self.pageIndicatorPosition == QPageIndicatorPositionRight) {
        
        pageX = scrollW - pageW - margin;
        pageY = scrollH - pageH - margin;
        
    } else if (self.pageIndicatorPosition == QPageIndicatorPositionLeftCenter) {
        
        self.pageControl.transform = CGAffineTransformMakeRotation(0.5 * M_PI);
        
        pageX = (pageH - pageW) / 2;
        pageY = (scrollH - pageH) / 2;
        
    } else if (self.pageIndicatorPosition == QPageIndicatorPositionRightCenter) {
        
        self.pageControl.transform = CGAffineTransformMakeRotation(0.5 * M_PI);
        
        pageX = scrollW - (pageH + pageW) / 2;
        pageY = (scrollH - pageH) / 2;
    }
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 设置首先显示的页码视图
    self.pageControl.currentPage = 0;
    
    // 设置图像视图的 frame
    for (int i = 0; i < ImageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * scrollH, scrollW, scrollH);
        } else {
            imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
        }
    }
    
    // 设置内容大小
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentSize = CGSizeMake(0, ImageViewCount * scrollH);
    } else {
        self.scrollView.contentSize = CGSizeMake(ImageViewCount * scrollW, 0);
    }
}

/// 设置显示的图像
- (void)setImageNames:(NSArray<NSString *> *)imageNames {
    
    _imageNames = imageNames;
    
    // 设置页码
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    
    // 设置内容
    [self updateContent];
    
    // 开始定时器
    if (self.isAutoScroll) {
        [self startTimer];
    }
}

/// 设置页码视图的颜色

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor {
    
    _currentPageIndicatorColor = currentPageIndicatorColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorColor;
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor {
    
    _pageIndicatorColor = pageIndicatorColor;
    self.pageControl.pageIndicatorTintColor = pageIndicatorColor;
}

/// 设置是否自动滚动
- (void)setAutoScroll:(BOOL)autoScroll {
    
    _autoScroll = autoScroll;
    
    if (!autoScroll) {
        
        [self stopTimer];
    }
}

/// 设置是否隐藏页码视图
- (void)setHidePageIndicator:(BOOL)hidePageIndicator {
    
    _hidePageIndicator = hidePageIndicator;
    
    if (_hidePageIndicator) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}

/// UIScrollViewDelegate 协议方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.isAutoScroll) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.isAutoScroll) {
        [self startTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self updateContent];
}

/// 更新显示的内容
- (void)updateContent {
    
    // 设置图片
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        
        imageView.tag = index;
        
        if (self.imageNames) {
            imageView.image = [UIImage imageNamed:self.imageNames[index]];
        }
    }
    
    // 设置偏移量在中间
    if (self.isScrollDirectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    } else {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
}

/// 定时器处理

- (void)startTimer {
    
    self.timer = [NSTimer timerWithTimeInterval:self.autoScrollTime target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    
    if (self.isScrollDirectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * self.scrollView.frame.size.width, 0) animated:YES];
    }
}

@end


NS_ASSUME_NONNULL_END
