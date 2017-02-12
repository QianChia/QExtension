//
//  NSDictionary+LocaleLogTests.m
//  QExtensionExample
//
//  Created by JHQ0228 on 2017/2/10.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSDictionary_LocaleLogTests : XCTestCase

@end

@implementation NSDictionary_LocaleLogTests

- (void)testDictionaryLocaleLog {
    
    NSDictionary *dic = @{@"你好":@"北京", @"你好吗":@"北京"};
    
    NSLog(@"%@", dic);
}

@end
