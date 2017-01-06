//
//  QQRCode.h
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/5.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+QRCode.h"

NS_ASSUME_NONNULL_BEGIN


@interface QQRCode : UIViewController

/**
*  创建扫描二维码界面，开始扫描二维码
*
*  @param result    扫描二维码结果 isSucceed == YES 扫描成功，isSucceed == NO 扫描失败
*
*  @return 扫描二维码视图控制器
*/
+ (instancetype)q_scanQRCode:(void (^)(BOOL isSucceed, NSString *result))result;

/// 生成我的二维码信息
@property (nonatomic, strong) NSString *myQRCodeInfo;
@property (nonatomic, strong) UIImage *headIcon;

@end


NS_ASSUME_NONNULL_END
