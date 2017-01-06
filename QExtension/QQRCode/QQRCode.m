//
//  QQRCode.m
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/5.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QQRCode.h"

#import <AVFoundation/AVFoundation.h>
#import "MyQRCodeVC.h"

NS_ASSUME_NONNULL_BEGIN


#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface QQRCode () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/// 输入输出的中间桥梁
@property (nonatomic, strong) AVCaptureSession *session;

/// 扫描窗口
@property (nonatomic, strong) UIImageView *scanView;

/// 扫描线
@property (nonatomic, strong) UIImageView *scanLine;

/// 扫描结果
@property (nonatomic, copy) void (^resultBlock)(BOOL, NSString *);

/// 定时器
@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation QQRCode

#pragma mark - 扫描二维码

/// 创建扫描二维码界面，开始扫描二维码
+ (instancetype)q_scanQRCode:(void (^)(BOOL, NSString *))result {
    
    QQRCode *qrCode = [[self alloc] init];
    
    qrCode.resultBlock = result;
    
    // 创建自定义扫描界面
    [qrCode q_creatdScanView];
    
    return qrCode;
}

/// 创建自定义扫描界面
- (void)q_creatdScanView {
    
    // 创建假导航
    
    UIImageView *navImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    navImageView.image = [UIImage imageNamed:@"scan_navbar"];
    navImageView.userInteractionEnabled = YES;
    [self.view addSubview:navImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH / 2 - 100, 20 , 200, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"二维码/条码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navImageView addSubview:titleLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"btn_back_pressed"] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"btn_back_nor"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(10, 15, 48, 48)];
    [backButton addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navImageView addSubview:backButton];
    
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherButton setImage:[UIImage imageNamed:@"btn_other_pressed"] forState:UIControlStateHighlighted];
    [otherButton setImage:[UIImage imageNamed:@"btn_other_nor"] forState:UIControlStateNormal];
    [otherButton setFrame:CGRectMake(WIDTH - 58, 15, 48, 48)];
    [otherButton addTarget:self action:@selector(pressOtherButton:) forControlEvents:UIControlEventTouchUpInside];
    [navImageView addSubview:otherButton];

    // 创建扫描框
    
    CGFloat margin1 = 0;                                 // 根据背景图片的大小长宽比设置扫描框的位置和长宽比
    CGRect scanViewFrame = CGRectMake(margin1, margin1 + 64, WIDTH - margin1 * 2, (WIDTH - margin1 * 2) * 2);
    
    self.scanView = [[UIImageView alloc] initWithFrame:scanViewFrame];
    self.scanView.image = [UIImage imageNamed:@"scan_bg_50"];
    [self.view addSubview:self.scanView];
    
    // 创建扫描线
    
    CGFloat margin2 = 50;
    CGRect scanLineFrame = CGRectMake(margin2, margin2 + 15, WIDTH - margin2 * 2, 4);
    
    self.scanLine = [[UIImageView alloc] initWithFrame:scanLineFrame];
    self.scanLine.image = [UIImage imageNamed:@"scan_line_blue"];
    [self.scanView addSubview:self.scanLine];
    
    // 开启扫描线上下移动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(timerLineAnimation)
                                                userInfo:nil
                                                 repeats:YES];
    
    // 创建扫描框下的提示文字
    
    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WIDTH - margin1 * 2 + 20, WIDTH, 40)];
    promptLabel.text = @"将二维码/条码放入框内，即可自动扫描";
    promptLabel.textColor = [UIColor whiteColor];
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.lineBreakMode = NSLineBreakByWordWrapping;
    promptLabel.numberOfLines = 2;
    promptLabel.font = [UIFont systemFontOfSize:12];
    promptLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:promptLabel];
    
    // 创建扫描框下方选择按钮
    
    UIImageView *toolBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT - 90, WIDTH, 90)];
    toolBarImageView.image = [UIImage imageNamed:@"scan_toolbar"];
    toolBarImageView.userInteractionEnabled = YES;
    [self.view addSubview:toolBarImageView];
    
    NSArray *unSelectImageNames = @[@"btn_photo_nor",
                                    @"btn_flash_on",
                                    @"btn_myqrcode_nor"];
    
    NSArray *selectImageNames = @[@"btn_photo_pressed",
                                  @"btn_flash_off",
                                  @"btn_myqrcode_pressed"];
    
    for (int i = 0; i < unSelectImageNames.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH / 3 * i, 0, WIDTH / 3, 90);
        [toolBarImageView addSubview:button];
        
        if (i == 1) {
            [button setImage:[UIImage imageNamed:unSelectImageNames[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:selectImageNames[i]] forState:UIControlStateSelected];
            
        } else {
            [button setImage:[UIImage imageNamed:unSelectImageNames[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:selectImageNames[i]] forState:UIControlStateHighlighted];
        }
        
        if (i == 0) {
            [button addTarget:self action:@selector(pressPhotoLibraryButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 1) {
            [button addTarget:self action:@selector(pressFlashLightButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (i == 2) {
            [button addTarget:self action:@selector(pressMyqrcodeButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 判断相机是否可用
    [self q_isCameraAvailable];
}

/// 返回按钮点击事件处理
- (void)pressBackButton:(UIButton *)btn {
    
    [self q_stopScan];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/// 更多按钮点击事件处理
- (void)pressOtherButton:(UIButton *)btn {
    
    [self q_stopScan];
    
//    NSLog(@"pressOtherButton");
}

/// 相册按钮点击事件处理
- (void)pressPhotoLibraryButton:(UIButton *)btn {
    
    // 从相册选择图片，识别二维码
    [self q_readQRCode];
}

/// 闪光灯按钮点击事件处理
- (void)pressFlashLightButton:(UIButton *)btn {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode == AVCaptureTorchModeOff) {
        
        [device lockForConfiguration:nil];
        
        // 开启闪光灯
        [device setTorchMode:AVCaptureTorchModeOn];
        
        btn.selected = YES;
        
    } else {
        
        // 关闭闪光灯
        [device setTorchMode:AVCaptureTorchModeOff];
        
        btn.selected = NO;
    }
}

/// 我的二维码按钮点击事件处理
- (void)pressMyqrcodeButton:(UIButton *)btn {
    
    MyQRCodeVC *qrCode = [MyQRCodeVC qrCodeWithInfo:self.myQRCodeInfo headIcon:self.headIcon];
    
    [self presentViewController:qrCode animated:YES completion:nil];
}

/// 扫描线上下移动定时响应事件
- (void)timerLineAnimation {
    
    CGFloat margin = 50;
    
    [UIView animateWithDuration:2 animations:^{
        
        // 底部位置
        self.scanLine.frame = CGRectMake(margin, margin + (WIDTH - margin * 2) - 20, WIDTH - margin * 2, 4);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2 animations:^{
            
            // 上部位置
            self.scanLine.frame = CGRectMake(margin, margin + 15, WIDTH - margin * 2, 4);
        }];
    }];
}

/// 判断相机是否可用
- (void)q_isCameraAvailable {
    
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    if (isCameraAvailable) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            
            // 相机不可用
            
            // 停止扫描
            [self q_stopScan];
            
            NSString *errorStr = [NSString stringWithFormat:@"请在系统设置->隐私->相机中允许 \"%@\" 使用相机。",
                                  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]];
            
            if (self.resultBlock) {
                self.resultBlock(NO, errorStr);
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            // 相机可用
            
            // 开始扫描
            [self q_startScan];
        }
    } else {
        if (self.resultBlock) {
            self.resultBlock(NO, @"相机不可用");
        }
        
        [self q_stopScan];
    }
}

/// 开始扫描
- (void)q_startScan {
    
    // 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];

    // 创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 设置代理，在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置有效扫描区域
    CGFloat margin = 50 + 10;
    CGRect scanFrame = CGRectMake(margin, margin + 64, WIDTH - margin * 2, WIDTH - margin * 2);
    
    output.rectOfInterest = [self q_getScanCropWithScanViewFrame:scanFrame
                                                readerViewBounds:self.view.bounds];
    
    // 初始化链接对象
    self.session = [[AVCaptureSession alloc] init];
    
    // 设置采集率，高质量
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [self.session addInput:input];
    [self.session addOutput:output];
    
    // 设置扫码支持的编码格式（如下设置条形码和二维码兼容）
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    // 开始捕获
    [self.session startRunning];
}

/// 停止扫描
- (void)q_stopScan {
    
    // 停止扫描
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
    
    // 关闭定时器
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

// 设置扫描区域的比例关系，自定义方法
- (CGRect)q_getScanCropWithScanViewFrame:(CGRect)scanViewFrame readerViewBounds:(CGRect)readerViewBounds {
    
    CGFloat x, y, width, height;
    
    x = scanViewFrame.origin.y / readerViewBounds.size.height;
    y = scanViewFrame.origin.x / readerViewBounds.size.width;
    width = scanViewFrame.size.height / readerViewBounds.size.height;
    height = scanViewFrame.size.width / readerViewBounds.size.width;
    
    return CGRectMake(x, y, width, height);
}

// 获取扫描结果，AVCaptureMetadataOutputObjectsDelegate 协议方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects.count > 0) {
        
        // 停止扫描
        [self q_stopScan];
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        
        // 获取扫描结果
        NSString *resultString = metadataObject.stringValue;
        
        // 输出扫描字符串
        if (self.resultBlock) {
            self.resultBlock(YES, resultString);
        }
        
        // 返回
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 读取二维码

/// 打开相册，选取图片
- (void)q_readQRCode {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 初始化相册拾取器
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        // 设置资源
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 设置代理
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        NSString *errorStr = [NSString stringWithFormat:@"请在系统设置->隐私->照片中允许 \"%@\" 使用照片。",
                              [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]];
        
        if (self.resultBlock) {
            self.resultBlock(NO, errorStr);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/// 获取选中的图片，识别二维码，imagePickerController 协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    // 识别图片中的二维码
    [self q_recognizeQRCodeFromImage:image];
    
    // 返回
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

/// 识别二维码
- (void)q_recognizeQRCodeFromImage:(UIImage *)image {
    
    NSString *resultString = [image q_recognizeQRCode];
    
    if ([resultString isEqualToString:@"该图片中不包含二维码"]) {
        
        if (self.resultBlock) {
            self.resultBlock(NO, resultString);
        }
    } else {
        
        if (self.resultBlock) {
            self.resultBlock(YES, resultString);
        }
    }
}


@end


NS_ASSUME_NONNULL_END
