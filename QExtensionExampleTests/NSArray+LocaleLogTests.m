//
//  NSArray+LocaleLogTests.m
//  QExtensionExample
//
//  Created by JHQ0228 on 2017/2/10.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSArray_LocaleLogTests : XCTestCase

@end

@implementation NSArray_LocaleLogTests

- (void)testArrayLocaleLog {
    
    NSArray *array = @[@"你好", @"北京"];
    NSLog(@"%@", array);
}

@end
