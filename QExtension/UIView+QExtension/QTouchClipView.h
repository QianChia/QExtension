//
//  QTouchClipView.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/14.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QTouchClipView : UIView

/**
 *  创建手势截屏视图控件，获取截屏结果
 *
 *  @param view     截取图片的视图控件
 *  @param result   手势截屏结果
 *
 *  @return 手势截屏视图控件
 */
+ (instancetype)q_touchClipViewWithView:(UIView *)view
                             clipResult:(void (^)(UIImage * _Nullable image))result;

@end


NS_ASSUME_NONNULL_END
