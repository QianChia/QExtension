//
//  QLockView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/8.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QLockView.h"

@interface QLockView ()

/// 存放选中的按钮
@property (nonatomic, strong) NSMutableArray *selectedArray;

/// 当前被选中的按钮
@property (nonatomic, assign) CGPoint currentPoint;

/// 扫描结果
@property (nonatomic, copy) void (^resultBlock)(BOOL, NSString *);

@end

@implementation QLockView

/// 创建手势锁界面，获取滑动结果
+ (instancetype)q_lockViewPathResult:(void (^)(BOOL isSucceed, NSString *result))result {
    
    QLockView *lockView = [[self alloc] init];
    
    lockView.resultBlock = result;
    
    return lockView;
}

/// 初始化界面
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加按钮
        for (int i = 0; i < 9; i++){
            
            UIButton *btn = [[UIButton alloc] init];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
            
            // 设置 tag 值，设置按钮对应的密码值
            btn.tag = i + 1;
            
            // 关闭按钮的交互，响应触摸事件
            btn.userInteractionEnabled = NO;
            
            [self addSubview:btn];
        }
    }
    return self;
}

/// 设置按钮的 frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        // 列数
        NSInteger cols = 3;
        
        // 设置按钮尺寸
        CGFloat W = self.bounds.size.width;
        CGFloat H = self.bounds.size.height;
        CGFloat btnW = W / 5;
        CGFloat btnH = H / 5;

        // 计算按钮的 x 坐标值
        NSUInteger col = i % cols;
        CGFloat btnX = col * btnW * 2;
        
        // 计算按钮的 y 坐标值
        NSUInteger row = i / cols;
        CGFloat btnY = row * btnH * 2;
        
        // 设置按钮的 frame
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

/// 触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取触摸起始点位置
    CGPoint startPoint = [touches.anyObject locationInView:self];
    
    // 获取其 button
    UIButton *button = nil;
    for (UIButton *btn in self.subviews) {
        
        // 判断某点在不在其 frame 上
        if (CGRectContainsPoint(btn.frame, startPoint)) {
            button = btn;
        }
    }
    
    // 选中此 button
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectedArray addObject:button];
    }
}

/// 触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 获取触摸点位置
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    
    // 获取其 button
    UIButton *button = nil;
    for (UIButton *btn in self.subviews) {
        
        // 判断某点在不在其 frame 上
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            button = btn;
        }
    }
    
    // 选中此 button
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectedArray addObject:button];
    } else {
        self.currentPoint = touchPoint;
    }
    
    // 刷新视图
    [self setNeedsDisplay];
}

/// 触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.selectedArray.count < 4) {
        
        // 触摸点数过少
        if (self.resultBlock) {
            self.resultBlock(NO, @"至少连续绘制四个点");
        }
        
        for (UIButton *btn in self.selectedArray) {
            
            btn.highlighted = YES;
            btn.selected = NO;
        }
        
        // 延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                      (int64_t)(0.5 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            
            [self clearPath];
        });
        
    } else {
    
        // 触摸完成
        if (self.resultBlock) {
            
            // 获取触摸结果
            NSMutableString *path = [NSMutableString string];
            for (UIButton *btn in self.selectedArray) {
                [path appendFormat:@"%ld", btn.tag];
            }
            
            self.resultBlock(YES, path);
        }
        
        [self clearPath];
    }
}

/// 触摸取消
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self touchesEnded:touches withEvent:event];
}

/// 绘制贝塞尔连接线
- (void)drawRect:(CGRect)rect {
    
    if (self.selectedArray.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];             // 创建一条贝塞尔曲线
    path.lineWidth = 5;                                         // 设置其曲线宽度
    path.lineJoinStyle = kCGLineCapRound;                       // 设置其曲线连接样式
    [[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5] set];    // 设置其曲线的颜色透明度
    
    for (int i = 0; i < self.selectedArray.count; i++) {
        
        UIButton *btn = self.selectedArray[i];
        
        // 如果是第一个按钮，则将其曲线的起点放在其按钮上，否则则进行连线
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 如果不满足上述条件，按钮不存在则连接到临时点
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

/// 清除连接线
- (void)clearPath {
    
    // 取消选中按钮
    for (UIButton *btn in self.selectedArray) {
        btn.highlighted = NO;
        btn.selected = NO;
    }
    
    // 清空选中按钮
    [self.selectedArray removeAllObjects];
    
    // 刷新视图
    [self setNeedsDisplay];
}

/// 懒加载
- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

@end
