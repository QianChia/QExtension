//
//  MyQRCodeVC.h
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/6.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQRCodeVC : UIViewController

+ (instancetype)qrCodeWithInfo:(NSString *)info headIcon:(UIImage *)headIcon;

/// 生成我的二维码信息
@property (nonatomic, strong) NSString *myQRCodeInfo;
@property (nonatomic, strong) UIImage *headIcon;

@end
