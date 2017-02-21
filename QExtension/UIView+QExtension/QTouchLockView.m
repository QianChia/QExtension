//
//  QTouchLockView.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QTouchLockView.h"
#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN


#define BUNDLE_IMAGE(name)  [self q_imageNamed:(name) fromBundle:@"QTouchLockView"]


@interface QTouchLockView ()

/// 存放选中的按钮
@property (nonatomic, strong) NSMutableArray *selectedArray;

/// 当前被选中的按钮
@property (nonatomic, assign) CGPoint currentPoint;

/// 滑动手势结果
@property (nonatomic, copy) void (^resultBlock)(BOOL, NSString *);

@end

@implementation QTouchLockView

/// 创建手势锁界面，获取滑动结果
+ (instancetype)q_touchLockViewWithFrame:(CGRect)frame
                              pathResult:(void (^)(BOOL isSucceed, NSString *result))result {
    
    QTouchLockView *touchLockView = [[self alloc] init];
    
    CGRect tmpFrame = frame;
    tmpFrame.size.height = frame.size.width;
    
    touchLockView.frame = tmpFrame;
    touchLockView.resultBlock = result;
    
    return touchLockView;
}

/// 初始化界面
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加提示信息框
        self.alertLabel = [[UILabel alloc] init];
        self.alertLabel.textAlignment = NSTextAlignmentCenter;
        self.alertLabel.textColor = [UIColor redColor];
        self.alertLabel.backgroundColor = [UIColor clearColor];
        self.alertLabel.numberOfLines = 1;
        self.alertLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.alertLabel];
        
        // 添加按钮
        for (int i = 0; i < 9; i++){
            
            UIButton *btn = [[UIButton alloc] init];
            
            [btn setBackgroundImage:BUNDLE_IMAGE(@"gesture_node_normal") forState:UIControlStateNormal];
            [btn setBackgroundImage:BUNDLE_IMAGE(@"gesture_node_selected") forState:UIControlStateSelected];
            [btn setBackgroundImage:BUNDLE_IMAGE(@"gesture_node_highlighted") forState:UIControlStateHighlighted];
            
            // 设置 tag 值，设置按钮对应的密码值
            btn.tag = (long)i + 1;
            
            // 关闭按钮的交互，响应触摸事件
            btn.userInteractionEnabled = NO;
            
            [self addSubview:btn];
        }
    }
    return self;
}

/// 布局控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的 frame
    for (int i = 0; i < self.subviews.count - 1; i++) {
        
        // 列数
        NSInteger cols = 3;
        
        // 设置按钮尺寸
        CGFloat W = self.bounds.size.width;
        CGFloat H = self.bounds.size.height;
        CGFloat btnW = W / 5;
        CGFloat btnH = H / 5;
        
        // 计算按钮的 x 坐标值
        NSInteger col = i % cols;
        CGFloat btnX = col * btnW * 2;
        
        // 计算按钮的 y 坐标值
        NSInteger row = i / cols;
        CGFloat btnY = row * btnH * 2;
        
        // 设置按钮的 frame
        UIButton *btn = self.subviews[i + 1];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 设置提示信息框的 frame
    self.alertLabel.frame = CGRectMake(0, -50, self.bounds.size.width, 30);
}

/// 触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(nullable UIEvent *)event {
    
    // 获取触摸起始点位置
    CGPoint startPoint = [touches.anyObject locationInView:self];
    
    // 获取其 button
    UIButton *button = nil;
    for (UIButton *btn in self.subviews) {
        
        // 设置触摸按钮的灵敏度
        CGRect frame = btn.frame;
        CGRect tmpFrame = CGRectMake(frame.origin.x + frame.size.width / 4,
                                     frame.origin.y + frame.size.height / 4,
                                     frame.size.width / 2,
                                     frame.size.height / 2);
        
        // 判断某点在不在其 frame 上
        if (CGRectContainsPoint(tmpFrame, startPoint)) {
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
- (void)touchesMoved:(NSSet *)touches withEvent:(nullable UIEvent *)event {
    
    // 获取触摸点位置
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    
    // 获取其 button
    UIButton *button = nil;
    for (UIButton *btn in self.subviews) {
        
        // 设置触摸按钮的灵敏度
        CGRect frame = btn.frame;
        CGRect tmpFrame = CGRectMake(frame.origin.x + frame.size.width / 4,
                                     frame.origin.y + frame.size.height / 4,
                                     frame.size.width / 2,
                                     frame.size.height / 2);
        
        // 判断某点在不在其 frame 上
        if (CGRectContainsPoint(tmpFrame, touchPoint)) {
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
- (void)touchesEnded:(NSSet *)touches withEvent:(nullable UIEvent *)event {
    
    if (self.selectedArray.count < 4) {
        
        // 触摸点数过少
        if (self.resultBlock) {
            self.resultBlock(NO, @"请至少连续连接四个点");
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
                [path appendFormat:@"%ld", (long)btn.tag];
            }
            
            // 对滑动获取的密码值进行 MD5 加密
            NSString *md5Path = [self q_md5String:path];
            
            self.resultBlock(YES, md5Path);
        }
        
        [self clearPath];
    }
}

/// 触摸取消
- (void)touchesCancelled:(NSSet *)touches withEvent:(nullable UIEvent *)event {
    
    [self touchesEnded:touches withEvent:event];
}

/// 绘制贝塞尔连接线
- (void)drawRect:(CGRect)rect {
    
    if (self.selectedArray.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    path.lineJoinStyle = kCGLineCapRound;
    [[UIColor colorWithRed:1 green:0 blue:0 alpha:0.5] set];
    
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

#pragma mark - 助手方法

/**
 *  从 Bundle 文件中加载图片
 *
 *  @param name         图片名称
 *  @param bundleName   Bundle 文件名称
 *
 *  <p> #define BUNDLE_IMAGE(name)  [self q_imageNamed:(name) fromBundle:@"DemoBundle"] <p>
 *
 *  @return 加载的图片
 */
- (UIImage *)q_imageNamed:(NSString *)name fromBundle:(NSString *)bundleName {
    
    NSMutableString *bundleN = [NSMutableString stringWithString:bundleName];
    
    if ([bundleName hasSuffix:@".bundle"] == NO) {
        [bundleN appendString:@".bundle"];
    }
    
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleN];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:name];
    
    return [UIImage imageWithContentsOfFile:filePath];
}

/**
 *  计算 MD5 散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @param  string  待求散列值的字符串
 *
 *  @return 32 个字符的 MD5 散列字符串
 */
- (NSString *)q_md5String:(NSString *)string {
    const char *str = string.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self q_stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)q_stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    return [strM copy];
}

@end


NS_ASSUME_NONNULL_END
