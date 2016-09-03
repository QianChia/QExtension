//
//  NSData+FormData.m
//  QExtension
//
//  Created by JHQ0228 on 16/7/7.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "NSData+FormData.h"

NS_ASSUME_NONNULL_BEGIN


#define QIAN_UPLOAD_BOUNDARY  @"qianUploadBoundary"


@implementation NSData (FormData)

#pragma mark - 带请求头设置上传数据

/// 不带文本，单文件上传

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                         fileData:(NSData *)fileData
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                         mimeType:(nullable NSString *)mimeType {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithFileData:fileData
                           fileBoundary:nil
                                   name:name
                               fileName:fileName
                               mimeType:mimeType];
}

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                          fileURL:(NSURL *)fileURL
                             name:(NSString *)name
                         fileName:(nullable NSString *)fileName
                         mimeType:(nullable NSString *)mimeType {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithFileURL:fileURL
                          fileBoundary:nil
                                  name:name
                              fileName:fileName
                              mimeType:mimeType];
}

/// 带文本，单文件上传

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                             text:(nullable id)text
                         textName:(nullable NSString *)textName
                         fileData:(NSData *)fileData
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                         mimeType:(nullable NSString *)mimeType {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithText:text
                           textName:textName
                           fileData:fileData
                       fileBoundary:nil
                               name:name
                           fileName:fileName
                           mimeType:mimeType];
}

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                             text:(nullable id)text
                         textName:(nullable NSString *)textName
                          fileURL:(NSURL *)fileURL
                             name:(NSString *)name
                         fileName:(nullable NSString *)fileName
                         mimeType:(nullable NSString *)mimeType {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithText:text
                           textName:textName
                            fileURL:fileURL
                       fileBoundary:nil
                               name:name
                           fileName:fileName
                           mimeType:mimeType];
}

/// 不带文本，多文件上传

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                        fileDatas:(NSArray<NSData *> *)fileDatas
                             name:(NSString *)name
                        fileNames:(NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithFileDatas:fileDatas
                            fileBoundary:nil
                                    name:name
                               fileNames:fileNames
                               mimeTypes:mimeTypes];
}

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                         fileURLs:(NSArray<NSURL *> *)fileURLs
                             name:(NSString *)name
                        fileNames:(nullable NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithFileURLs:fileURLs
                           fileBoundary:nil
                                   name:name
                              fileNames:fileNames
                              mimeTypes:mimeTypes];
}

/// 带文本，多文件上传

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                            texts:(nullable NSArray<id> *)texts
                        textNames:(nullable NSArray<NSString *> *)textNames
                        fileDatas:(NSArray<NSData *> *)fileDatas
                             name:(NSString *)name
                        fileNames:(NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithTexts:texts
                           textNames:textNames
                           fileDatas:fileDatas
                        fileBoundary:nil
                                name:name
                           fileNames:fileNames
                           mimeTypes:mimeTypes];
}

+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                            texts:(nullable NSArray<id> *)texts
                        textNames:(nullable NSArray<NSString *> *)textNames
                         fileURLs:(NSArray<NSURL *> *)fileURLs
                             name:(NSString *)name
                        fileNames:(nullable NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    [self q_setHttpHeaderFieldWithRequest:request fileBoundary:nil];
    
    return [self q_formDataWithTexts:texts
                           textNames:textNames
                            fileURLs:fileURLs
                        fileBoundary:nil
                                name:name
                           fileNames:fileNames
                           mimeTypes:mimeTypes];
}

#pragma mark - 工具方法

/**
 *  设置文件上传请求头
 *
 *  设置上传文件前，需先设置请求头，请求头用的 boundary 和文件拼接用的需相同。
 *
 *  @param request      网络请求
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 */
+ (void)q_setHttpHeaderFieldWithRequest:(NSMutableURLRequest *)request
                           fileBoundary:(nullable NSString *)fileBoundary {
    
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@", fileBoundary ? : QIAN_UPLOAD_BOUNDARY] forHTTPHeaderField:@"Content-Type"];
}

/**
 *  判断并拼接文本内容
 *
 *  @param text         文本内容字符串，text = nil 或 text = [NSNull null] 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，textName = nil 或 textName = [NSNull null] 默认不添加文本内容
 *  @param fileBoundary 文件分隔符
 *
 *  @return 拼接的文本内容二进制数据
 */
+ (NSData *)q_appendPartWithText:(nullable id)text
                        textName:(nullable NSString *)textName
                    fileBoundary:(nullable NSString *)fileBoundary {
    
    NSMutableData *formDataM = [NSMutableData data];
    
    [formDataM q_appendPartWithText:text
                           textName:textName
                       fileBoundary:fileBoundary];
    
    return formDataM;
}

/**
 *  判断并拼接文件内容
 *
 *  @param fileData     文件数据
 *  @param fileBoundary 文件分隔符
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，mimeType = nil 或 mimeType = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的文件内容二进制数据
 */
+ (NSData *)q_appendPartWithFileData:(NSData *)fileData
                        fileBoundary:(nullable NSString *)fileBoundary
                                name:(NSString *)name
                            fileName:(NSString *)fileName
                            mimeType:(nullable NSString *)mimeType {
    
    NSMutableData *formDataM = [NSMutableData data];
    
    [formDataM q_appendPartWithFileData:fileData
                           fileBoundary:fileBoundary
                                   name:name
                               fileName:fileName
                               mimeType:mimeType];
    
    return formDataM;
}

/**
 *  判断并转换文件名，将文件路径中指定的文件转换为二进制数据
 *
 *  @param fileName     在服务器端上的文件存储名，fileName = nil 或 fileName = [NSNull null] 默认以文件原来的名字存储
 *  @param fileURL      文件路径
 *
 *  @return 包含文件名及文件二进制数据的数组
 */
+ (NSArray *)q_uploadNameAndDataWithFileName:(nullable NSString *)fileName
                                     fileURL:(NSURL *)fileURL {
    
    NSString *uploadName = (fileName && fileName != (id)[NSNull null]) ? fileName : fileURL.lastPathComponent;
    NSData *uploadData = [NSData dataWithContentsOfFile:fileURL.path];

    return @[uploadName, uploadData];
}

/**
 *  判断并转换数组中的文件名，将文件路径数组中指定的文件转换为二进制数据
 *
 *  @param fileNames    在服务器端上的文件存储名，fileNames = nil 或 fileName[] = [NSNull null] 默认以文件原来的名字存储
 *  @param fileURLs     文件路径
 *
 *  @return 包含文件名数组及文件二进制数据数组的二维数组
 */
+ (NSArray *)q_uploadNamesAndDatasWithFileNames:(nullable NSArray<NSString *> *)fileNames
                                       fileURLs:(NSArray<NSURL *> *)fileURLs {
    
    NSMutableArray *fileURLsM = [NSMutableArray arrayWithArray:fileURLs];
    NSMutableArray *fileNamesM = (fileNames == nil) ? nil : [NSMutableArray arrayWithArray:fileNames];
    
    NSUInteger fileURLsMCount = fileURLsM.count;
    NSUInteger fileNamesMCount = fileNamesM.count;
    
    if (fileNamesMCount < fileURLsMCount) {
        for (int i = 0; i < (fileURLsMCount - fileNamesMCount); i++) {
            [fileNamesM addObject:[NSNull null]];
        }
    }
    
    NSUInteger count = fileURLsM.count;
    
    NSMutableArray<NSString *> *uploadNames = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray<NSData *> *uploadDatas = [NSMutableArray arrayWithCapacity:count];
    NSArray *uploadNameAndData = [[NSArray alloc] init];
    
    for (int i = 0; i < count; i ++) {
        uploadNameAndData = [self q_uploadNameAndDataWithFileName:fileNamesM[i] fileURL:fileURLsM[i]];
        uploadNames[i] = uploadNameAndData[0];
        uploadDatas[i] = uploadNameAndData[1];
    }
    return @[uploadNames, uploadDatas];
}

/**
 *  封装 “文件数据”，不带文本内容，单文件
 *
 *  @param fileData     文件数据
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据
 */
+ (NSData *)q_formDataWithFileData:(NSData *)fileData
                      fileBoundary:(nullable NSString *)fileBoundary
                              name:(NSString *)name
                          fileName:(NSString *)fileName
                          mimeType:(nullable NSString *)mimeType {
    
    NSMutableData *formDataM = [NSMutableData data];
    
    [formDataM appendData:[self q_appendPartWithFileData:fileData
                                            fileBoundary:fileBoundary
                                                    name:name
                                                fileName:fileName
                                                mimeType:mimeType]];
    
    [formDataM q_appendPartEndingWithFileBoundary:fileBoundary];
    
    return formDataM;
}

/**
 *  封装 “文件路径”，不带文本内容，单文件
 *
 *  @param fileURL      文件路径
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名，nil 默认以文件原来的名字存储
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据
 */
+ (NSData *)q_formDataWithFileURL:(NSURL *)fileURL
                     fileBoundary:(nullable NSString *)fileBoundary
                             name:(NSString *)name
                         fileName:(nullable NSString *)fileName
                         mimeType:(nullable NSString *)mimeType {
    
    NSArray *uploadNameAndData = [self q_uploadNameAndDataWithFileName:fileName fileURL:fileURL];
    
    return [self q_formDataWithFileData:uploadNameAndData[1]
                           fileBoundary:fileBoundary
                                   name:name
                               fileName:uploadNameAndData[0]
                               mimeType:mimeType];
}

/**
 *  封装 “文件数据”，带文本内容，单文件
 *
 *  @param text         文本内容字符串，nil 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，nil 默认不添加文本内容
 *  @param fileData     文件数据
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据
 */
+ (NSData *)q_formDataWithText:(nullable id)text
                      textName:(nullable NSString *)textName
                      fileData:(NSData *)fileData
                  fileBoundary:(nullable NSString *)fileBoundary
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(nullable NSString *)mimeType {
    
    NSMutableData *formDataM = [NSMutableData data];
    
    [formDataM appendData:[self q_appendPartWithText:text
                                            textName:textName
                                        fileBoundary:fileBoundary]];
    
    [formDataM appendData:[self q_formDataWithFileData:fileData
                                          fileBoundary:fileBoundary
                                                  name:name
                                              fileName:fileName
                                              mimeType:mimeType]];
    
    return formDataM;
}

/**
 *  封装 “文件路径”，带文本内容，单文件
 *
 *  @param text         文本内容字符串，nil 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，nil 默认不添加文本内容
 *  @param fileURL      文件路径
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名，nil 默认以文件原来的名字存储
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据
 */
+ (NSData *)q_formDataWithText:(nullable id)text
                      textName:(nullable NSString *)textName
                       fileURL:(NSURL *)fileURL
                  fileBoundary:(nullable NSString *)fileBoundary
                          name:(NSString *)name
                      fileName:(nullable NSString *)fileName
                      mimeType:(nullable NSString *)mimeType {
    
    NSArray *uploadNameAndData = [self q_uploadNameAndDataWithFileName:fileName fileURL:fileURL];
    
    return [self q_formDataWithText:text
                           textName:textName
                           fileData:uploadNameAndData[1]
                       fileBoundary:fileBoundary
                               name:name
                           fileName:uploadNameAndData[0]
                           mimeType:mimeType];
}

/**
 *  封装 “文件数据”，不带文本内容，多文件
 *
 *  @param fileDatas    文件数据
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据
 */
+ (NSData *)q_formDataWithFileDatas:(NSArray<NSData *> *)fileDatas
                       fileBoundary:(nullable NSString *)fileBoundary
                               name:(NSString *)name
                          fileNames:(NSArray<NSString *> *)fileNames
                          mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    NSMutableArray *fileDatasM = [NSMutableArray arrayWithArray:fileDatas];
    NSMutableArray *fileNamesM = [NSMutableArray arrayWithArray:fileNames];
    NSMutableArray *mimeTypesM = (mimeTypes == nil) ? nil : [NSMutableArray arrayWithArray:mimeTypes];
    
    NSUInteger fileDatasMCount = fileDatasM.count;
    NSUInteger fileNamesMCount = fileNamesM.count;
    NSUInteger mimeTypesMCount = mimeTypesM.count;
    
    if (fileNamesMCount < fileDatasMCount) {
        for (int i = 0; i < (fileDatasMCount - fileNamesMCount); i++) {
            [fileNamesM addObject:[NSNull null]];
        }
    }
    
    if (mimeTypesMCount < fileDatasMCount) {
        for (int i = 0; i < (fileDatasMCount - mimeTypesMCount); i++) {
            [mimeTypesM addObject:[NSNull null]];
        }
    }
    
    NSMutableData *formDataM = [NSMutableData data];
    
    for (int i = 0; i < fileDatasMCount; i ++) {
        [formDataM appendData:[self q_appendPartWithFileData:fileDatasM[i]
                                                fileBoundary:fileBoundary
                                                        name:name
                                                    fileName:fileNamesM[i]
                                                    mimeType:mimeTypesM[i]]];
    }
    
    [formDataM q_appendPartEndingWithFileBoundary:fileBoundary];
    
    return formDataM;
}

/**
 *  封装 “文件路径”，不带文本内容，多文件
 *
 *  @param fileURLs     文件路径
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名，fileNames = nil 或 fileName[] = [NSNull null] 默认以文件原来的名字存储
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据
 */
+ (NSData *)q_formDataWithFileURLs:(NSArray<NSURL *> *)fileURLs
                      fileBoundary:(nullable NSString *)fileBoundary
                              name:(NSString *)name
                         fileNames:(nullable NSArray<NSString *> *)fileNames
                         mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    NSArray *uploadNamesAndDatas = [self q_uploadNamesAndDatasWithFileNames:fileNames
                                                                   fileURLs:fileURLs];
    
    return [self q_formDataWithFileDatas:uploadNamesAndDatas[1]
                            fileBoundary:fileBoundary
                                    name:name
                               fileNames:uploadNamesAndDatas[0]
                               mimeTypes:mimeTypes];
}

/**
 *  封装 “文件数据”，带文本内容，多文件
 *
 *  @param texts        文本内容字符串，texts = nil 或 texts[] = [NSNull null] 默认不添加文本内容
 *  @param textNames    服务器规定的文本内容字段名，textNames = nil 或 textNames[] = [NSNull null] 默认不添加文本内容
 *  @param fileDatas    文件数据
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据
 */
+ (NSData *)q_formDataWithTexts:(nullable NSArray<id> *)texts
                      textNames:(nullable NSArray<NSString *> *)textNames
                      fileDatas:(NSArray<NSData *> *)fileDatas
                   fileBoundary:(nullable NSString *)fileBoundary
                           name:(NSString *)name
                      fileNames:(NSArray<NSString *> *)fileNames
                      mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    NSMutableArray *textsM = (texts == nil) ? nil : [NSMutableArray arrayWithArray:texts];
    NSMutableArray *textNamesM = (textNames == nil) ? nil : [NSMutableArray arrayWithArray:textNames];
    
    NSUInteger textsMCount = textsM.count;
    NSUInteger textNamesMCount = textNamesM.count;
    
    if (textsMCount < textNamesMCount) {
        for (int i = 0; i < (textNamesMCount - textsMCount); i++) {
            [textsM addObject:[NSNull null]];
        }
    }
    
    NSMutableData *formDataM = [NSMutableData data];
    
    for (int i = 0; i < textNamesMCount; i ++) {
        [formDataM appendData:[self q_appendPartWithText:textsM[i]
                                                textName:textNamesM[i]
                                            fileBoundary:fileBoundary]];
    }
    
    [formDataM appendData:[self q_formDataWithFileDatas:fileDatas
                                           fileBoundary:fileBoundary
                                                   name:name
                                              fileNames:fileNames
                                              mimeTypes:mimeTypes]];
    
    return formDataM;
}

/**
 *  封装 “文件路径”，带文本内容，多文件
 *
 *  @param texts        文本内容字符串，texts = nil 或 texts[] = [NSNull null] 默认不添加文本内容
 *  @param textNames    服务器规定的文本内容字段名，textNames = nil 或 textNames[] = [NSNull null] 默认不添加文本内容
 *  @param fileURLs     文件路径
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名，fileNames = nil 或 fileName[] = [NSNull null] 默认以文件原来的名字存储
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据
 */
+ (NSData *)q_formDataWithTexts:(nullable NSArray<id> *)texts
                      textNames:(nullable NSArray<NSString *> *)textNames
                       fileURLs:(NSArray<NSURL *> *)fileURLs
                   fileBoundary:(nullable NSString *)fileBoundary
                           name:(NSString *)name
                      fileNames:(nullable NSArray<NSString *> *)fileNames
                      mimeTypes:(nullable NSArray<NSString *> *)mimeTypes {
    
    NSArray *uploadNamesAndDatas = [self q_uploadNamesAndDatasWithFileNames:fileNames
                                                                   fileURLs:fileURLs];
    
    return [self q_formDataWithTexts:texts
                           textNames:textNames
                           fileDatas:uploadNamesAndDatas[1]
                        fileBoundary:fileBoundary
                                name:name
                           fileNames:uploadNamesAndDatas[0]
                           mimeTypes:mimeTypes];
}

@end


@implementation NSMutableData (FormData)

#pragma mark - 上传数据拼接

/// 设置文件上传请求头

- (void)q_setHttpHeaderFieldWithRequest:(NSMutableURLRequest *)request
                           fileBoundary:(nullable NSString *)fileBoundary {
    
    [NSData q_setHttpHeaderFieldWithRequest:request fileBoundary:fileBoundary];
}

/// 判断并拼接文本内容

- (void)q_appendPartWithText:(nullable id)text
                    textName:(nullable NSString *)textName
                fileBoundary:(nullable NSString *)fileBoundary {
    
    if (!((text && text != (id)[NSNull null]) && (textName && textName != (id)[NSNull null]))) return;
    
    [self appendData:[[NSString stringWithFormat:@"--%@\r\n", fileBoundary ? : QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", textName, text] dataUsingEncoding:NSUTF8StringEncoding]];
}

/// 判断并拼接文件内容，文件数据

- (void)q_appendPartWithFileData:(NSData *)fileData
                    fileBoundary:(nullable NSString *)fileBoundary
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(nullable NSString *)mimeType {
    
    [self appendData:[[NSString stringWithFormat:@"--%@\r\n", fileBoundary ? : QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n", (mimeType && mimeType != (id)[NSNull null]) ? mimeType : @"application/octet-stream"] dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [self appendData:fileData];
    [self appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
}

/// 判断并拼接文件内容，文件路径

- (void)q_appendPartWithFileURL:(NSURL *)fileURL
                   fileBoundary:(nullable NSString *)fileBoundary
                           name:(NSString *)name
                       fileName:(nullable NSString *)fileName
                       mimeType:(nullable NSString *)mimeType {
    
    NSArray *uploadNameAndData = [NSData q_uploadNameAndDataWithFileName:fileName fileURL:fileURL];
    
    [self q_appendPartWithFileData:uploadNameAndData[1]
                      fileBoundary:fileBoundary
                              name:name
                          fileName:uploadNameAndData[0]
                          mimeType:mimeType];
}

/// 拼接数据结束分隔符

- (void)q_appendPartEndingWithFileBoundary:(nullable NSString *)fileBoundary {
    
    [self appendData:[[NSString stringWithFormat:@"--%@--\r\n", fileBoundary ? : QIAN_UPLOAD_BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
}

@end


NS_ASSUME_NONNULL_END
