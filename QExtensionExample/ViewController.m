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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self nsArrayLocaleLogDemo];
}


#pragma mark - NSArray+QExtension

/// LocaleLog
- (void)nsArrayLocaleLogDemo {
    
    NSArray *localeArray = @[@"hello", @"你好", @"欢迎"];
    
    NSLog(@"%@", localeArray);
}
























































@end

