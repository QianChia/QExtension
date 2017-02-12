//
//  NSData+FormDataTests.m
//  QExtensionExample
//
//  Created by JHQ0228 on 2017/2/10.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSData+FormData.h"

#define QIAN_UPLOAD_BOUNDARY  @"QianChiaUploadBoundary"

@interface NSData_FormDataTests : XCTestCase

@property (nonatomic, strong) NSMutableURLRequest *request;

@property (nonatomic, strong) NSMutableData *formData;

@property (nonatomic, strong) NSData *filedata1;
@property (nonatomic, strong) NSData *filedata2;

@property (nonatomic, strong) NSURL *fileURL1;
@property (nonatomic, strong) NSURL *fileURL2;

@property (nonatomic, strong) NSMutableData *formData1;
@property (nonatomic, strong) NSMutableData *formData2;

@property (nonatomic, strong) NSMutableData *formTextData1;
@property (nonatomic, strong) NSMutableData *formTextData2;

@property (nonatomic, strong) NSMutableData *formURLData1;
@property (nonatomic, strong) NSMutableData *formURLData2;

@property (nonatomic, strong) NSMutableData *formTextURLData1;
@property (nonatomic, strong) NSMutableData *formTextURLData2;

@end

@implementation NSData_FormDataTests

- (void)setUp {
    [super setUp];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload/upload.php"];
    
    self.request = [NSMutableURLRequest requestWithURL:url];
    
    self.formData = [NSMutableData data];
    
    self.filedata1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    self.filedata2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
    
    self.fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
    self.fileURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
}

- (NSMutableData *)formData1 {
    
    if (_formData1 == nil) {
        
        NSData *fileData = self.filedata1;
        NSString *name = @"userfile";
        NSString *fileName = @"test1.png";
        NSString *mimeType = @"image/png";
        
        _formData1 = [NSMutableData data];
        [_formData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData1 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData1 appendData:fileData];
        [_formData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData1 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formData1;
}

- (NSMutableData *)formData2 {
    
    if (_formData2 == nil) {
        
        NSData *fileData1 = self.filedata1;
        NSData *fileData2 = self.filedata2;
        NSString *name = @"userfile[]";
        NSString *fileName1 = @"test1.png";
        NSString *fileName2 = @"test2.jpg";
        NSString *mimeType1 = @"image/png";
        NSString *mimeType2 = @"image/jpeg";
        
        _formData2 = [NSMutableData data];
        
        [_formData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType1]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:fileData1];
        [_formData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName2] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType2]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formData2 appendData:fileData2];
        [_formData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formData2 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formData2;
}

- (NSMutableData *)formTextData1 {
    
    if (_formTextData1 == nil) {
        
        NSString *text = @"QianChia_test1";
        NSString *textName = @"username";
        
        NSData *fileData = self.filedata1;
        NSString *name = @"userfile";
        NSString *fileName = @"test1.png";
        NSString *mimeType = @"image/png";
        
        _formTextData1 = [NSMutableData data];
        
        [_formTextData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", textName, text] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType]
                                    dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:fileData];
        [_formTextData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData1 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formTextData1;
}

- (NSMutableData *)formTextData2 {
    
    if (_formTextData2 == nil) {
        
        NSString *text = @"QianChia_test2";
        NSString *textName = @"username";
        
        NSData *fileData1 = self.filedata1;
        NSData *fileData2 = self.filedata2;
        NSString *name = @"userfile[]";
        NSString *fileName1 = @"test1.png";
        NSString *fileName2 = @"test2.jpg";
        NSString *mimeType1 = @"image/png";
        NSString *mimeType2 = @"image/jpeg";
        
        _formTextData2 = [NSMutableData data];
        
        [_formTextData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", textName, text] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType1]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:fileData1];
        [_formTextData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName2] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType2]
                                dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextData2 appendData:fileData2];
        [_formTextData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextData2 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formTextData2;
}

- (NSMutableData *)formURLData1 {
    
    if (_formURLData2 == nil) {
        
        NSURL *fileURL = self.fileURL1;
        NSString *name = @"userfile";
        NSString *fileName = @"test1.png";
        NSString *mimeType = @"image/png";
        
        _formURLData2 = [NSMutableData data];
        [_formURLData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType]
                                   dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData2 appendData:[NSData dataWithContentsOfFile:fileURL.path]];
        [_formURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData2 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formURLData2;
}

- (NSMutableData *)formURLData2 {
    
    if (_formURLData1 == nil) {
        
        NSURL *fileURL1 = self.fileURL1;
        NSURL *fileURL2 = self.fileURL2;
        NSString *name = @"userfile[]";
        NSString *fileName1 = @"test1.png";
        NSString *fileName2 = @"test2.jpg";
        NSString *mimeType1 = @"image/png";
        NSString *mimeType2 = @"image/jpeg";
        
        _formURLData1 = [NSMutableData data];
        
        [_formURLData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType1]
                                   dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[NSData dataWithContentsOfFile:fileURL1.path]];
        [_formURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formURLData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName2] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType2]
                                   dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formURLData1 appendData:[NSData dataWithContentsOfFile:fileURL2.path]];
        [_formURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formURLData1 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formURLData1;
}

- (NSMutableData *)formTextURLData1 {
    
    if (_formTextURLData1 == nil) {
        
        NSString *text = @"QianChia_test1";
        NSString *textName = @"username";
        
        NSURL *fileURL = self.fileURL1;
        NSString *name = @"userfile";
        NSString *fileName = @"test1.png";
        NSString *mimeType = @"image/png";
        
        _formTextURLData1 = [NSMutableData data];
        
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", textName, text] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType]
                                       dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[NSData dataWithContentsOfFile:fileURL.path]];
        [_formTextURLData1 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData1 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formTextURLData1;
}

- (NSMutableData *)formTextURLData2 {
    
    if (_formTextURLData2 == nil) {
        
        NSString *text = @"QianChia_test2";
        NSString *textName = @"username";
        
        NSURL *fileURL1 = self.fileURL1;
        NSURL *fileURL2 = self.fileURL2;
        NSString *name = @"userfile[]";
        NSString *fileName1 = @"test1.png";
        NSString *fileName2 = @"test2.jpg";
        NSString *mimeType1 = @"image/png";
        NSString *mimeType2 = @"image/jpeg";
        
        _formTextURLData2 = [NSMutableData data];
        
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", textName, text] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName1] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType1]
                                   dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[NSData dataWithContentsOfFile:fileURL1.path]];
        [_formTextURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName2] dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType2]
                                   dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [_formTextURLData2 appendData:[NSData dataWithContentsOfFile:fileURL2.path]];
        [_formTextURLData2 appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [_formTextURLData2 appendData:[[NSString stringWithFormat:@"--%@--\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return _formTextURLData2;
}

- (void)tearDown {
    
    self.request = nil;
    
    self.formData = nil;
    
    self.filedata1 = nil;
    self.filedata2 = nil;
    self.fileURL1 = nil;
    self.fileURL2 = nil;
    
    self.formData1 = nil;
    self.formData2 = nil;
    self.formTextData1 = nil;
    self.formTextData2 = nil;
    self.formURLData1 = nil;
    self.formURLData2 = nil;
    self.formTextURLData1 = nil;
    self.formTextURLData2 = nil;
    
    [super tearDown];
}

#pragma mark - FormData Tests

// 单文件上传，指定 “文件数据” 形式，不带文本内容
- (void)testFormDataWithRequestFileDataNameFileNameMimeType {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                            fileData:self.filedata1
                                                name:@"userfile"
                                            fileName:@"test1.png"
                                            mimeType:@"image/png"];
    
    XCTAssertEqualObjects(formData, self.formData1, @"formData 与 self.formData1 不相等");
}

// 单文件上传，指定 “文件路径” 形式，不带文本内容
- (void)testFormDataWithRequestFileURLNameFileNameMimeType {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                             fileURL:self.fileURL1
                                                name:@"userfile"
                                            fileName:@"test1.png"
                                            mimeType:@"image/png"];
    
    XCTAssertEqualObjects(formData, self.formURLData1, @"formData 与 self.formURLData1 不相等");
}

// 单文件上传，指定 “文件数据” 形式，带文本内容
- (void)testFormDataWithRequestTextTextNameFileDataNameFileNameMimeType {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                                text:@"QianChia_test1"
                                            textName:@"username"
                                            fileData:self.filedata1
                                                name:@"userfile"
                                            fileName:@"test1.png"
                                            mimeType:@"image/png"];
    
    XCTAssertEqualObjects(formData, self.formTextData1, @"formData 与 self.formTextData1 不相等");
}

// 单文件上传，指定 “文件路径” 形式，带文本内容
- (void)testFormDataWithRequestTextTextNameFileURLNameFileNameMimeType {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                                text:@"QianChia_test1"
                                            textName:@"username"
                                             fileURL:self.fileURL1
                                                name:@"userfile"
                                            fileName:@"test1.png"
                                            mimeType:@"image/png"];
    
    XCTAssertEqualObjects(formData, self.formTextURLData1, @"formData 与 self.formTextURLData1 不相等");
}

// 多文件上传，指定 “文件数据” 形式，不带文本内容
- (void)testFormDataWithRequestFileDatasNameFileNamesMimeTypes {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                           fileDatas:@[self.filedata1, self.filedata2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test1.png", @"test2.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    XCTAssertEqualObjects(formData, self.formData2, @"formData 与 self.formData2 不相等");
}

// 多文件上传，指定 “文件路径” 形式，不带文本内容
- (void)testFormDataWithRequestFileURLNameFileNamesMimeTypes {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                            fileURLs:@[self.fileURL1, self.fileURL2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test1.png", @"test2.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    XCTAssertEqualObjects(formData, self.formURLData2, @"formData 与 self.formURLData2 不相等");
}

// 多文件上传，指定 “文件数据” 形式，带文本内容
- (void)testFormDataWithRequestTextsTextNamesFileDatasNameFileNamesMimeTypes {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                               texts:@[@"QianChia_test2"]
                                           textNames:@[@"username"]
                                           fileDatas:@[self.filedata1, self.filedata2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test1.png", @"test2.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    XCTAssertEqualObjects(formData, self.formTextData2, @"formData 与 self.formTextData2 不相等");
}

// 多文件上传，指定 “文件路径” 形式，带文本内容
- (void)testFormDataWithRequestTextsTextNamesFileURLsNameFileNamesMimeTypes {
    
    NSData *formData = [NSData q_formDataWithRequest:self.request
                                               texts:@[@"QianChia_test2"]
                                           textNames:@[@"username"]
                                            fileURLs:@[self.fileURL1, self.fileURL2]
                                                name:@"userfile[]"
                                           fileNames:@[@"test1.png", @"test2.jpg"]
                                           mimeTypes:@[@"image/png", @"image/jpeg"]];
    
    XCTAssertEqualObjects(formData, self.formTextURLData2, @"formData 与 self.formTextURLData2 不相等");
}

// 设置文件上传请求头
- (void)testSetHttpHeaderFieldWithRequestFileBoundary {
    
    [self.formData q_setHttpHeaderFieldWithRequest:self.request fileBoundary:QIAN_UPLOAD_BOUNDARY];
    
    NSString *contentType = self.request.allHTTPHeaderFields[@"Content-Type"];
    
    XCTAssertEqualObjects(contentType, @"multipart/form-data; charset=utf-8; boundary=QianChiaUploadBoundary", @"请求头设置错误");
}

// 判断并拼接文本内容
- (void)testAppendPartWithTextTextNameFileBoundary {
    
    [self.formData q_appendPartWithText:@"QianChia" textName:@"username" fileBoundary:QIAN_UPLOAD_BOUNDARY];
    NSString *formString1 = [[NSString alloc] initWithData:self.formData encoding:NSUTF8StringEncoding];
    
    NSMutableData *formData = [NSMutableData data];
    [formData appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", @"username", @"QianChia"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *formString2 = [[NSString alloc] initWithData:formData encoding:NSUTF8StringEncoding];
    
    XCTAssertEqualObjects(formString1, formString2, @"拼接文本内容错误");
}

// 判断并拼接文件内容，文件数据
- (void)testAappendPartWithFileDataFileBoundaryNameFileNameMimeType {
    
    [self.formData q_appendPartWithFileData:self.filedata1 fileBoundary:QIAN_UPLOAD_BOUNDARY name:@"userfile" fileName:@"test1.png" mimeType:@"image/png"];
    NSString *formString1 = [[NSString alloc] initWithData:self.formData encoding:NSUTF8StringEncoding];
    
    NSMutableData *formData = [NSMutableData data];
    [formData appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                       @"userfile", @"test1.png"]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", @"image/png"]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:self.filedata1];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *formString2 = [[NSString alloc] initWithData:formData encoding:NSUTF8StringEncoding];
    
    XCTAssertEqualObjects(formString1, formString2, @"拼接文件内容文件数据错误");
}

// 判断并拼接文件内容，文件路径
- (void)testAappendPartWithFileURLFileBoundaryNameFileNameMimeType {
    
    [self.formData q_appendPartWithFileURL:self.fileURL1 fileBoundary:QIAN_UPLOAD_BOUNDARY name:@"userfile" fileName:@"test1.png" mimeType:@"image/png"];
    NSString *formString1 = [[NSString alloc] initWithData:self.formData encoding:NSUTF8StringEncoding];
    
    NSMutableData *formData = [NSMutableData data];
    [formData appendData:[[NSString stringWithFormat:@"--%@\r\n", QIAN_UPLOAD_BOUNDARY]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",
                           @"userfile", @"test1.png"]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", @"image/png"]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [formData appendData:[NSData dataWithContentsOfFile:self.fileURL1.path]];
    [formData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *formString2 = [[NSString alloc] initWithData:formData encoding:NSUTF8StringEncoding];
    
    XCTAssertEqualObjects(formString1, formString2, @"拼接文件内容文件路径错误");
}

// 拼接数据结束分隔符
- (void)testAappendPartEndingWithFileBoundary {
    
    [self.formData q_appendPartEndingWithFileBoundary:QIAN_UPLOAD_BOUNDARY];
    NSString *formString = [[NSString alloc] initWithData:self.formData encoding:NSUTF8StringEncoding];
    
    XCTAssertEqualObjects(formString, @"--QianChiaUploadBoundary--", @"拼接数据结束分隔符错误");
}

@end
