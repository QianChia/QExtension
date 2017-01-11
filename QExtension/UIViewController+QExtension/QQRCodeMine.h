//
//  QQRCodeMine.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface QQRCodeMine : UIViewController

/// 生成我的二维码信息
@property (nonatomic, strong) NSString *myQRCodeInfo;
@property (nonatomic, strong) UIImage *headIcon;

+ (instancetype)qrCodeWithInfo:(NSString *)info headIcon:(UIImage *)headIcon;

@end


NS_ASSUME_NONNULL_END
