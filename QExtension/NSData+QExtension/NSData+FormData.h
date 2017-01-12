//
//  NSData+FormData.h
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSData (FormData)

#pragma mark - 带请求头文件上传数据设置

/**
 *  单文件上传，指定 “文件数据” 形式，不带文本内容
 *
 *  @param request      网络请求
 *  @param fileData     文件数据
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *                      <p> image/jpeg                  图片文件 <p>
 *                      <p> image/png                   图片文件 <p>
 *                      <p> image/gif                   图片文件 <p>
 *                      <p> audio/mpeg                  mp3 文件 <p>
 *                      <p> video/mp4                   mp4 文件 <p>
 *                      <p> text/html                   html 文本文件 <p>
 *                      <p> text/plain                  txt 文本文件 <p>
 *                      <p> text/rtf                    rtf 文本文件 <p>
 *                      <p> application/pdf             pdf 文件 <p>
 *                      <p> application/json            json 文件 <p>
 *                      <p> application/octet-stream    8 进制流，如果不想告诉服务器具体的文件类型，可以使用这个 <p>
 *
 *  @return 拼接的待上传文件的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                         fileData:(NSData *)fileData
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                         mimeType:(nullable NSString *)mimeType;

/**
 *  单文件上传，指定 “文件路径” 形式，不带文本内容
 *
 *  @param request      网络请求
 *  @param fileURL      文件路径
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名，nil 默认以文件原来的名字存储
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                          fileURL:(NSURL *)fileURL
                             name:(NSString *)name
                         fileName:(nullable NSString *)fileName
                         mimeType:(nullable NSString *)mimeType;

/**
 *  单文件上传，指定 “文件数据” 形式，带文本内容
 *
 *  @param request      网络请求
 *  @param text         文本内容字符串，nil 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，nil 默认不添加文本内容
 *  @param fileData     文件数据
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                             text:(nullable id)text
                         textName:(nullable NSString *)textName
                         fileData:(NSData *)fileData
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                         mimeType:(nullable NSString *)mimeType;

/**
 *  单文件上传，指定 “文件路径” 形式，带文本内容
 *
 *  @param request      网络请求
 *  @param text         文本内容字符串，nil 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，nil 默认不添加文本内容
 *  @param fileURL      文件路径
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名，nil 默认以文件原来的名字存储
 *  @param mimeType     文件类型，nil 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                             text:(nullable id)text
                         textName:(nullable NSString *)textName
                          fileURL:(NSURL *)fileURL
                             name:(NSString *)name
                         fileName:(nullable NSString *)fileName
                         mimeType:(nullable NSString *)mimeType;

/**
 *  多文件上传，指定 “文件数据” 形式，不带文本内容
 *
 *  @param request      网络请求
 *  @param fileDatas    文件数据
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                        fileDatas:(NSArray<NSData *> *)fileDatas
                             name:(NSString *)name
                        fileNames:(NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes;

/**
 *  多文件上传，指定 “文件路径” 形式，不带文本内容
 *
 *  @param request      网络请求
 *  @param fileURLs     文件路径
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名，fileNames = nil 或 fileName[] = [NSNull null] 默认以文件原来的名字存储
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                         fileURLs:(NSArray<NSURL *> *)fileURLs
                             name:(NSString *)name
                        fileNames:(nullable NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes;

/**
 *  多文件上传，指定 “文件数据” 形式，带文本内容
 *
 *  @param request      网络请求
 *  @param texts        文本内容字符串，texts = nil 或 texts[] = [NSNull null] 默认不添加文本内容
 *  @param textNames    服务器规定的文本内容字段名，textNames = nil 或 textNames[] = [NSNull null] 默认不添加文本内容
 *  @param fileDatas    文件数据
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                            texts:(nullable NSArray<id> *)texts
                        textNames:(nullable NSArray<NSString *> *)textNames
                        fileDatas:(NSArray<NSData *> *)fileDatas
                             name:(NSString *)name
                        fileNames:(NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes;

/**
 *  多文件上传，指定 “文件路径” 形式，带文本内容
 *
 *  @param request      网络请求
 *  @param texts        文本内容字符串，texts = nil 或 texts[] = [NSNull null] 默认不添加文本内容
 *  @param textNames    服务器规定的文本内容字段名，textNames = nil 或 textNames[] = [NSNull null] 默认不添加文本内容
 *  @param fileURLs     文件路径
 *  @param name         服务器规定的文件字段名
 *  @param fileNames    在服务器端上的文件存储名，fileNames = nil 或 fileName[] = [NSNull null] 默认以文件原来的名字存储
 *  @param mimeTypes    文件类型，mimeTypes = nil 或 mimeTypes[] = [NSNull null] 默认设置为 application/octet-stream 通用类型
 *
 *  @return 拼接的待上传文件及文本的二进制数据，fileBoundary 文件分隔符默认设置为 @"qianUploadBoundary"
 */
+ (NSData *)q_formDataWithRequest:(NSMutableURLRequest *)request
                            texts:(nullable NSArray<id> *)texts
                        textNames:(nullable NSArray<NSString *> *)textNames
                         fileURLs:(NSArray<NSURL *> *)fileURLs
                             name:(NSString *)name
                        fileNames:(nullable NSArray<NSString *> *)fileNames
                        mimeTypes:(nullable NSArray<NSString *> *)mimeTypes;

@end


@interface NSMutableData (FormData)

#pragma mark - 文件上传数据拼接

/**
 *  设置文件上传请求头
 *
 *  设置上传文件前，需先设置请求头，请求头用的 boundary 和文件拼接用的需相同。
 *
 *  @param request      网络请求
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 */
- (void)q_setHttpHeaderFieldWithRequest:(NSMutableURLRequest *)request
                           fileBoundary:(nullable NSString *)fileBoundary;

/**
 *  判断并拼接文本内容
 *
 *  @param text         文本内容字符串，text = nil 或 text = [NSNull null] 默认不添加文本内容
 *  @param textName     服务器规定的文本内容字段名，textName = nil 或 textName = [NSNull null] 默认不添加文本内容
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 */
- (void)q_appendPartWithText:(nullable id)text
                    textName:(nullable NSString *)textName
                fileBoundary:(nullable NSString *)fileBoundary;

/**
 *  判断并拼接文件内容，文件数据
 *
 *  @param fileData     文件数据
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，mimeType = nil 或 mimeType = [NSNull null] 默认设置为 application/octet-stream 通用类型
 */
- (void)q_appendPartWithFileData:(NSData *)fileData
                    fileBoundary:(nullable NSString *)fileBoundary
                            name:(NSString *)name
                        fileName:(NSString *)fileName
                        mimeType:(nullable NSString *)mimeType;

/**
 *  判断并拼接文件内容，文件路径
 *
 *  @param fileURL      文件路径
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 *  @param name         服务器规定的文件字段名
 *  @param fileName     在服务器端上的文件存储名
 *  @param mimeType     文件类型，mimeType = nil 或 mimeType = [NSNull null] 默认设置为 application/octet-stream 通用类型
 */
- (void)q_appendPartWithFileURL:(NSURL *)fileURL
                   fileBoundary:(nullable NSString *)fileBoundary
                           name:(NSString *)name
                       fileName:(nullable NSString *)fileName
                       mimeType:(nullable NSString *)mimeType;

/**
 *  拼接数据结束分隔符
 *
 *  @param fileBoundary 文件分隔符，nil 默认设置为 @"qianUploadBoundary"
 */
- (void)q_appendPartEndingWithFileBoundary:(nullable NSString *)fileBoundary;

@end


NS_ASSUME_NONNULL_END
