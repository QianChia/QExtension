//
//  QTouchLockView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QTouchLockView : UIView

/// 提示信息框
@property (nonatomic, strong) IBInspectable UILabel *alertLabel;

/**
 *  创建手势锁视图控件，获取滑动手势结果
 *
 *  @param frame    手势锁视图控件的位置尺寸
 *  @param result   滑动手势结果，YES 成功，NO 失败
 *
 *  @return 手势锁视图控件
 */
+ (instancetype)q_touchLockViewWithFrame:(CGRect)frame
                              pathResult:(void (^)(BOOL isSucceed, NSString *result))result;

@end


NS_ASSUME_NONNULL_END
