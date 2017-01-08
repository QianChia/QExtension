//
//  QLockView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/8.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLockView : UIView

/**
 *  创建手势锁界面，获取滑动结果
 *
 *  @param result   手势锁结果 isSucceed == YES 成功，isSucceed == NO 失败
 *
 *  @return 手势锁密码字符串
 */
+ (instancetype)q_lockViewPathResult:(void (^)(BOOL isSucceed, NSString *result))result;

@end
