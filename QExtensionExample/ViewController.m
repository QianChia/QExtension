//
//  ViewController.m
//  QExtensionExample
//
//  Created by JHQ0228 on 16/7/18.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"

#import "QExtension.h"

@interface ViewController ()
    
@end

@implementation ViewController

/// BundlePath

- (void)bundlePathDemo {
    
    NSString *filePath = @"~/Desktop/file.txt";
    
    NSString *documentPath = [filePath q_appendDocumentPath];
    NSLog(@"documentPath: %@\n\n", documentPath);
    
    NSString *md5DocumentPath = [filePath q_appendMD5DocumentPath];
    NSLog(@"md5DocumentPath: %@\n\n", md5DocumentPath);
    
    NSString *cachePath = [filePath q_appendCachePath];
    NSLog(@"cachePath: %@\n\n", cachePath);
    
    NSString *md5CachePath = [filePath q_appendMD5CachePath];
    NSLog(@"md5CachePath: %@\n\n", md5CachePath);
    
    NSString *tempPath = [filePath q_appendTempPath];
    NSLog(@"tempPath: %@\n\n", tempPath);
    
    NSString *md5TempPath = [filePath q_appendMD5TempPath];
    NSLog(@"md5TempPath: %@\n\n", md5TempPath);
}

/// Base64

- (void)base64Demo {
    
    NSString *str = @"hello world";
    
    NSString *base64Str = [str q_base64Encode];
    NSLog(@"base64Str: %@", base64Str);
    
    NSString *asciiStr = [base64Str q_base64Decode];
    NSLog(@"asciiStr: %@", asciiStr);
    
    NSString *authStr = [str q_basic64AuthEncode];
    NSLog(@"authStr: %@", authStr);
}

/// Hash

- (void)hashDemo {
    
    NSString *str = @"hello world";
    
    NSString *md5Str = [str q_md5String];
    NSLog(@"md5Str: %@", md5Str);
    
    NSString *hmacStr = [str q_hmacMD5StringWithKey:@"yourKey"];
    NSLog(@"hmacStr: %@", hmacStr);
    
    NSString *timeStr = [str q_timeMD5StringWithKey:@"yourKey"];
    NSLog(@"timeStr: %@", timeStr);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    NSString *fileMD5Str = [filePath q_fileMD5Hash];
    NSLog(@"fileMD5Str: %@", fileMD5Str);
}

/// Regex

- (void)regexDemo {
    
    NSString *mobileNum = @"15188886666";
    BOOL isValidMobileNum = [mobileNum q_isValidMobileNum];
    NSLog(@"isValidMobileNum: %zi", isValidMobileNum);
    
    NSString *emailAddress = @"qianchia@icloud.com";
    BOOL q_isValidEmailAddress = [emailAddress q_isValidEmailAddress];
    NSLog(@"isValidEmailAddress: %zi", q_isValidEmailAddress);
}

/// FormData

- (void)formDataDemo1 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /// 单文件上传简单封装

        #define boundary @"uploadBoundary"
        
        NSMutableData *formData = [NSMutableData data];
        
        [formData q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];                                                  // 设置请求头
        
        [formData q_appendPartWithFileURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]]
                             fileBoundary:boundary
                                     name:@"userfile"
                                 fileName:@"test1.png"
                                 mimeType:@"image/png"];                                                                           // 添加文件
        
        [formData q_appendPartWithText:@"qian" textName:@"username" fileBoundary:boundary];                                        // 添加文本
        
        [formData q_appendPartEndingWithFileBoundary:boundary];                                                                    // 添加结束分隔符
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"文件上传成功：\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

- (void)formDataDemo2 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /// 单文件上传封装
    
        NSData *filedata = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];

        NSData *formData = [NSData q_formDataWithRequest:request
                                                    text:@"qian"
                                                textName:@"username"
                                                fileData:filedata
                                                    name:@"userfile"
                                                fileName:@"test2.png"
                                                mimeType:@"image/png"];
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"文件上传成功：\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

- (void)formDataDemo3 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload-m.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /// 多文件上传封装
    
        NSData *filedata1 = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
        NSData *filedata2 = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];

//        NSData *formData = [NSData q_formDataWithRequest:request
//                                               fileDatas:@[filedata1, filedata2]
//                                                    name:@"userfile[]"
//                                               fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
//                                               mimeTypes:@[@"image/png", @"image/jpeg"]];
    
        NSData *formData = [NSData q_formDataWithRequest:request
                                                   texts:@[@"qian"]
                                               textNames:@[@"username"]
                                               fileDatas:@[filedata1, filedata2]
                                                    name:@"userfile[]"
                                               fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
                                               mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"文件上传成功：\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

- (void)formDataDemo4 {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload-m.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    /// 多文件上传封装
    
        NSURL *fileURL1 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
        NSURL *fileURL2 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
//        NSData *formData = [NSData q_formDataWithRequest:request
//                                                fileURLs:@[fileURL1, fileURL2]
//                                                    name:@"userfile[]"
//                                               fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
//                                               mimeTypes:@[@"image/png", @"image/jpeg"]];
    
        NSData *formData = [NSData q_formDataWithRequest:request
                                                   texts:@[@"qian"]
                                               textNames:@[@"username"]
                                                fileURLs:@[fileURL1, fileURL2]
                                                    name:@"userfile[]"
                                               fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
                                               mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"文件上传成功：\n%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]);
    }] resume];
}

/// Progress

- (IBAction)progressButton:(UIButton *)sender {
    
    [sender q_setButtonWithProgress:0.5 lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
}

/// QPageView

- (void)pageViewDemo {
    
    // 创建分页视图控件
    
    QPageView *pageView1 = [[QPageView alloc] init];
    
    QPageView *pageView2 = [[QPageView alloc] initWithFrame:CGRectMake(0, 20, 300, 150)];
    
    QPageView *pageView3 = [QPageView q_pageView];
    
    QPageView *pageView4 = [QPageView q_pageViewWithImageNames:@[@"img_00", @"img_01", @"img_02"]
                                                    autoScroll:YES
                                                autoScrollTime:2.0
                                         pageIndicatorPosition:Right];
    
    NSLog(@"%@", pageView1);
    NSLog(@"%@", pageView2);
    NSLog(@"%@", pageView3);
    NSLog(@"%@", pageView4);
}

- (void)pageViewDemo1 {
    
    // 创建分页视图控件
    QPageView *pageView = [QPageView q_pageView];
    
    pageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2);
    
    // 设置显示的图片
    pageView.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    
    // 设置页码视图的颜色
    pageView.currentPageIndicatorColor = [UIColor redColor];
    pageView.pageIndicatorColor = [UIColor greenColor];
    
    // 设置页码视图的位置
    pageView.pageIndicatorPosition = Right;
    
    // 设置是否隐藏页码视图
    pageView.hidePageIndicator = NO;
    
    // 设置滚动方向
    pageView.scrollDirectionPortrait = YES;
    
    [self.view addSubview:pageView];
}

- (void)pageViewDemo2 {
    
    // 设置显示的图片
    NSArray *imageNameArr = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    
    // 创建分页视图控件
    QPageView *pageView = [QPageView q_pageViewWithImageNames:imageNameArr
                                                   autoScroll:YES
                                               autoScrollTime:3.0
                                        pageIndicatorPosition:Center];
    
    pageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2);
    
    [self.view addSubview:pageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self bundlePathDemo];
    
//    [self base64Demo];
    
//    [self hashDemo];
    
    [self regexDemo];
    
//    [self formDataDemo1];
    
//    [self formDataDemo2];
    
//    [self formDataDemo3];
    
//    [self formDataDemo4];
    
//    [self pageViewDemo1];
    
//    [self pageViewDemo2];
}


@end

