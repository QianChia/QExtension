![Logo](https://avatars3.githubusercontent.com/u/13508076?v=3&s=460)
# QExtension

- The extension method for Foundation & UIKit Class.

GitHub：[QianChia](https://github.com/QianChia) ｜ Blog：[QianChia(Chinese)](http://www.cnblogs.com/QianChia)

---
## Installation

### From CocoaPods

- `pod 'QExtension'`

### Manually
- Drag all source files under floder `QExtension` to your project.
- Import the main header file：`#import "QExtension.h"`

---
## Examples


## 1、NSArray Extension

### 1.1 LocaleLog methods

- 本地化打印输出
	
	```objc
		
		Xcode 没有针对国际化语言做特殊处理，直接 Log 数组，只打印 UTF8 的编码，不能显示中文。
		
		- (NSString *)descriptionWithLocale:(nullable id)locale;
		
		重写这个方法，就能够解决输出问题，这个方法是专门为了本地话提供的一个调试方法，只要重写，
		不需要导入头文件，程序中所有的 NSLog 数组的方法，都会被替代。
		
	```
	
	```objc
		
		NSArray *localeArray = @[@"hello", @"你好", @"欢迎"];
		NSLog(@"%@", localeArray);
		
	```
	
	- 效果，使用前后对比
	
		![o_QExtension1](http://images.cnblogs.com/cnblogs_com/QianChia/934664/o_QExtension1.png)

		![t_QExtension2](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension2.png)


## 2、NSData Extension

### 2.1 FormData methods

- 文件上传拼接，指定文件数据

	```objc
	
		NSMutableData *formData = [NSMutableData data];
		    
		// 设置分割字符串
		static NSString *boundary = @"uploadBoundary";
		    
		// 设置请求头
		[formData q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
		    
		// 添加文件
		NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		[formData q_appendPartWithFileData:filedata
		                      fileBoundary:boundary
		                              name:@"userfile"
		                          fileName:@"test1.png"
		                          mimeType:@"image/png"];
		    
		// 添加文本内容
		[formData q_appendPartWithText:@"QianChia_test1" textName:@"username" fileBoundary:boundary];
		    
		// 添加结束分隔符
		[formData q_appendPartEndingWithFileBoundary:boundary];
    
	```	

	- 效果
	
		![t_QExtension3](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension3.png)

- 文件上传拼接，指定文件路径

	```objc
	
		NSMutableData *formData = [NSMutableData data];
		    
		// 设置分割字符串
		static NSString *boundary = @"uploadBoundary";
		    
		// 设置请求头
		[formData q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
		    
		// 添加文件
		NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		[formData q_appendPartWithFileURL:fileURL
		                     fileBoundary:boundary
		                             name:@"userfile"
		                         fileName:@"test2.png"
		                         mimeType:@"image/png"];
		    
		// 添加文本内容
		[formData q_appendPartWithText:@"QianChia_test2" textName:@"username" fileBoundary:boundary];
		    
		// 添加结束分隔符
		[formData q_appendPartEndingWithFileBoundary:boundary];
    
	```	

	- 效果
	
		![t_QExtension4](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension4.png)

- 单文件上传封装，指定文件数据，不带文本内容

	```objc
	
		// 添加文件
		NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                        fileData:filedata
		                                            name:@"userfile"
		                                        fileName:@"test3.png"
		                                        mimeType:@"image/png"];
    
	```	

	- 效果
	
		![t_QExtension5](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension5.png)

- 单文件上传封装，指定文件路径，不带文本内容

	```objc
	
		// 添加文件
		NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                        fileURL:fileURL
		                                            name:@"userfile"
		                                        fileName:@"test4.png"
		                                        mimeType:@"image/png"];
    
	```	

	- 效果
	
		![t_QExtension6](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension6.png)

- 单文件上传封装，指定文件数据，带文本内容

	```objc
	
		// 添加文件
		NSData *filedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                            text:@"QianChia_test5"
		                                        textName:@"username"
		                                        fileData:filedata
		                                            name:@"userfile"
		                                        fileName:@"test5.png"
		                                        mimeType:@"image/png"];
    
	```	

	- 效果
	
		![t_QExtension7](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension7.png)

- 单文件上传封装，指定文件路径，带文本内容

	```objc
	
		// 添加文件
		NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                            text:@"QianChia_test6"
		                                        textName:@"username"
		                                         fileURL:fileURL
		                                            name:@"userfile"
		                                        fileName:@"test6.png"
		                                        mimeType:@"image/png"];
    
	```	

	- 效果
	
		![t_QExtension8](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension8.png)

- 多文件上传封装，指定文件数据，不带文本内容

	```objc
	
		// 添加文件
		NSData *filedata1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		NSData *filedata2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                       fileDatas:@[filedata1, filedata2]
		                                            name:@"userfile[]"
		                                       fileNames:@[@"test7.png", @"test7.jpg"]
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	```	

	- 效果
	
		![t_QExtension9](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension9.png)

- 多文件上传封装，指定文件路径，不带文本内容

	```objc
	
		// 添加文件
		NSURL *fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		NSURL *fileURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                        fileURLs:@[fileURL1, fileURL2]
		                                            name:@"userfile[]"
		                                       fileNames:@[@"test8.png", @"test8.jpg"]
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	```	

	- 效果
	
		![t_QExtension10](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension10.png)

- 多文件上传封装，指定文件数据，带文本内容

	```objc
	
		// 添加文件
		NSData *filedata1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		NSData *filedata2 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                           texts:@[@"QianChia_test9"]
		                                       textNames:@[@"username"]
		                                       fileDatas:@[filedata1, filedata2]
		                                            name:@"userfile[]"
		                                       fileNames:@[@"test9.png", @"test9.jpg"]
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	```	

	- 效果
	
		![t_QExtension11](http://images.cnblogs.com/cnblogs_com/QianChia/934664/o_QExtension11.png)

- 多文件上传封装，指定文件路径，带文本内容

	```objc
	
		// 添加文件
		NSURL *fileURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"png"]];
		NSURL *fileURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"jpg"]];
		    
		NSData *formData = [NSData q_formDataWithRequest:request
		                                           texts:@[@"QianChia_test10"]
		                                       textNames:@[@"username"]
		                                        fileURLs:@[fileURL1, fileURL2]
		                                            name:@"userfile[]"
		                                       fileNames:@[@"test10.png", @"test10.jpg"]
		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
	```	

	- 效果
	
		![t_QExtension12](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension12.png)


## 3、NSDictionary Extension

### 3.1 LocaleLog methods

- 本地化打印输出
	
	```objc
		
		Xcode 没有针对国际化语言做特殊处理，直接 Log 数组，只打印 UTF8 的编码，不能显示中文。
		
		- (NSString *)descriptionWithLocale:(nullable id)locale;
		
		重写这个方法，就能够解决输出问题，这个方法是专门为了本地话提供的一个调试方法，只要重写，
		不需要导入头文件，程序中所有的 NSLog 数组的方法，都会被替代。
		
	```
	
	```objc
		
		NSArray *localeArray = @[@"hello", @"你好", @"欢迎"];
		NSLog(@"%@", localeArray);
		
	```
	
	- 效果，使用前后对比
	
		![t_QExtension13](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension13.png)

		![t_QExtension14](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension14.png)


## 4、NSString Extension

### 4.1 Base64 methods 

- Base64 加密解密

	```objc
	
		NSString *str = @"hello world";
		    
		// Base64 编码
		NSString *base64Str = [str q_base64Encode];
		NSLog(@"base64Str: %@", base64Str);
		    
		// Base64 解码
		NSString *asciiStr = [base64Str q_base64Decode];
		NSLog(@"asciiStr: %@", asciiStr);
		    
		// 服务器基本授权字符串编码
		NSString *authStr = [str q_basic64AuthEncode];
		NSLog(@"authStr: %@", authStr);
    	
	```
	
	- 效果

		![t_QExtension15](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension15.png)
	
### 4.2 BundlePath methods

- 文件路径拼接

	```objc
	
		NSString *filePath = @"~/Desktop/file.txt";
		    
		// 拼接文档路径
		    
		NSString *documentPath = [filePath q_appendDocumentPath];
		NSLog(@"documentPath: \n%@\n\n", documentPath);
		    
		NSString *md5DocumentPath = [filePath q_appendMD5DocumentPath];
		NSLog(@"md5DocumentPath: \n%@\n\n", md5DocumentPath);
		    
		// 拼接缓存路径
		    
		NSString *cachePath = [filePath q_appendCachePath];
		NSLog(@"cachePath: \n%@\n\n", cachePath);
		    
		NSString *md5CachePath = [filePath q_appendMD5CachePath];
		NSLog(@"md5CachePath: \n%@\n\n", md5CachePath);
		    
		// 拼接临时路径
		    
		NSString *tempPath = [filePath q_appendTempPath];
		NSLog(@"tempPath: \n%@\n\n", tempPath);
		    
		NSString *md5TempPath = [filePath q_appendMD5TempPath];
		NSLog(@"md5TempPath: \n%@\n\n", md5TempPath);
		
	```

	- 效果

		![t_QExtension16](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension16.png)

### 4.3 Hash methods 

- 散列函数

	```objc
	
		NSString *str = @"hello world";
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
		    
		// 散列
		    
		NSString *md5Str = [str q_md5String];
		NSLog(@"md5Str: %@", md5Str);
		    
		NSString *sha1Str = [str q_sha1String];
		NSLog(@"sha1Str: %@", sha1Str);
		    
		NSString *sha224Str = [str q_sha224String];
		NSLog(@"sha224Str: %@", sha224Str);
		    
		NSString *sha256Str = [str q_sha256String];
		NSLog(@"sha256Str: %@", sha256Str);
		    
		NSString *sha384Str = [str q_sha384String];
		NSLog(@"sha384Str: %@", sha384Str);
		    
		NSString *sha512Str = [str q_sha512String];
		NSLog(@"sha512Str: %@\n\n", sha512Str);
		    
		// hmac 散列
		    
		NSString *hmacMD5Str = [str q_hmacMD5StringWithKey:@"yourKey"];
		NSLog(@"hmacMD5Str: %@", hmacMD5Str);
		    
		NSString *hmacSHA1Str = [str q_hmacSHA1StringWithKey:@"yourKey"];
		NSLog(@"hmacSHA1Str: %@", hmacSHA1Str);
		    
		NSString *hmacSHA224Str = [str q_hmacSHA224StringWithKey:@"yourKey"];
		NSLog(@"hmacSHA224Str: %@", hmacSHA224Str);
		    
		NSString *hmacSHA256Str = [str q_hmacSHA256StringWithKey:@"yourKey"];
		NSLog(@"hmacSHA256Str: %@", hmacSHA256Str);
		    
		NSString *hmacSHA384Str = [str q_hmacSHA384StringWithKey:@"yourKey"];
		NSLog(@"hmacSHA384Str: %@", hmacSHA384Str);
		    
		NSString *hmacSHA512Str = [str q_hmacSHA512StringWithKey:@"yourKey"];
		NSLog(@"hmacSHA512Str: %@\n\n", hmacSHA512Str);
		    
		// 时间戳 MD5 散列
		    
		NSString *timeStr = [str q_timeMD5StringWithKey:@"yourKey"];
		NSLog(@"timeStr: %@\n\n", timeStr);
		    
		// 文件 散列
		    
		NSString *fileMD5Str = [filePath q_fileMD5Hash];
		NSLog(@"fileMD5Str: %@", fileMD5Str);
		    
		NSString *fileSHA1Str = [filePath q_fileSHA1Hash];
		NSLog(@"fileSHA1Str: %@", fileSHA1Str);
		    
		NSString *fileSHA256Str = [filePath q_fileSHA256Hash];
		NSLog(@"fileSHA256Str: %@", fileSHA256Str);
		    
		NSString *fileSHA512Str = [filePath q_fileSHA512Hash];
		NSLog(@"fileSHA512Str: %@", fileSHA512Str);
    	
	```

	- 效果

		![t_QExtension17](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension17.png)
		
### 4.4 Regex methods 

- 正则表达式

	```objc
	
		// 验证手机号码的有效性
		    
		NSString *mobileNum1 = @"15188886666";
		BOOL isValidMobileNum1 = [mobileNum1 q_isValidMobileNum];
		NSLog(@"MobileNum1: %zi", isValidMobileNum1);
		    
		NSString *mobileNum2 = @"19188886666";
		BOOL isValidMobileNum2 = [mobileNum2 q_isValidMobileNum];
		NSLog(@"MobileNum2: %zi", isValidMobileNum2);
		    
		// 验证邮箱的有效性
		    
		NSString *emailAddress1 = @"qianchia@icloud.com";
		BOOL isValidEmailAddress1 = [emailAddress1 q_isValidEmailAddress];
		NSLog(@"EmailAddress1: %zi", isValidEmailAddress1);
		    
		NSString *emailAddress2 = @"qian@chia@icloud.com";
		BOOL isValidEmailAddress2 = [emailAddress2 q_isValidEmailAddress];
		NSLog(@"EmailAddress2: %zi", isValidEmailAddress2);
    	
	```

	- 效果

		![t_QExtension18](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension18.png)


## 5、UIButton Extension

### 5.1 QProgressButton methods

- 进度按钮

	```objc

		// 创建进度按钮
		QProgressButton *progressButton = [QProgressButton q_progressButtonWithFrame:CGRectMake(100, 100, 100, 50)
		                                                                       title:@"开始下载"
		                                                                   lineWidth:10
		                                                                   lineColor:[UIColor blueColor]
		                                                                   textColor:[UIColor redColor]
		                                                             backgroundColor:[UIColor yellowColor]
		                                                                     isRound:YES];
		    
		// 设置按钮点击事件
		[progressButton addTarget:self action:@selector(progressUpdate:) forControlEvents:UIControlEventTouchUpInside];
		    
		// 将按钮添加到当前控件显示
		[self.view addSubview:progressButton];
		
		// 设置按钮的进度值
		self.progressButton.progress = progress;
		
		// 设置按钮的进度终止标题，一旦设置了此标题进度条就会停止
		self.progressButton.stopTitle = @"下载完成";

	```

	- 效果

		![t_QExtension19](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension19.gif)  ![t_QExtension20](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension20.gif)

		![t_QExtension21](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension21.gif)  ![t_QExtension22](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension22.gif)

## 6、UIImage Extension

### 6.1 Draw methods

- 截取全屏幕图

	```objc
	
		UIImage *image = [UIImage q_imageWithScreenShot];
	
	```
	
	- 效果
	
		![t_QExtension23](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension23.png)  ![t_QExtension24](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension24.png)

- 截取指定视图控件屏幕图

	```objc
	
		UIImage *image = [UIImage q_imageWithScreenShotFromView:self.imageView1];
	
	```
	
	- 效果
	
		![t_QExtension25](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension25.png)  ![t_QExtension26](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension26.png)

- 调整图片的尺寸

	```objc
	
		UIImage *image = [[UIImage imageNamed:@"demo2.jpg"] q_imageByScalingAndCroppingToSize:CGSizeMake(200, 200)];
	
	```
	
	- 效果
	
		![t_QExtension27](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension27.png)  ![t_QExtension28](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension28.png)

- 裁剪圆形图片

	```objc
	
		UIImage *image = [[UIImage imageNamed:@"demo2.jpg"] q_imageByCroppingToRound];
	
	```
	
	- 效果
	
		![t_QExtension29](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension29.png)  ![t_QExtension30](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension30.pngg)

### 6.2 GIF methods

- GIF 动图

	```objc

    	// 通过名称加载 gif 图片，不需要写扩展名
    	self.imageView1.image = [UIImage q_gifImageNamed:@"demo3"];
	
    	// 通过数据加载 gif 图片
    	NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo3" ofType:@"gif"]];
    	self.imageView1.image = [UIImage q_gifImageWithData:imageData];

	```

	- 效果

		![t_QExtension31](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension31.gif)

### 6.3 QRCode methods

- 生成二维码

	```objc

		UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
		                                               headIcon:nil
		                                                  color:nil
		                                              backColor:nil];
		    
		UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
		                                               headIcon:[UIImage imageNamed:@"demo6"]
		                                                  color:[UIColor blackColor]
		                                              backColor:[UIColor whiteColor]];

	```

	- 效果

		![t_QExtension32](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension32.png)  ![t_QExtension33](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension33.png)

- 识别二维码

	```objc

		NSString *result = [image q_stringByRecognizeQRCode];

	```

	- 效果

		![t_QExtension34](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension34.gif)


## 7、UIView Extension

### 7.1 Frame methods

- 直接设置控件的位置尺寸值

	```objc
	
        view.x = 20;
        view.y = 200;
        view.width = 200;
        view.height = 100;
        
        view.centerX = 160;
        view.centerY = 300;
        
        view.size = CGSizeMake(100, 200);
	
	```

	- 效果

		![t_QExtension35](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension35.gif)

### 7.2 QPageView methods
 	
- 分页视图

	```objc
	
		// 创建分页视图控件
		CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width / 2);
		    
		QPageView *pageView = [[QPageView alloc] initWithFrame:frame];
		    
		// 设置显示的图片
		pageView.imageNames = @[@"page_00", @"page_01", @"page_02", @"page_03", @"page_04"];
		    
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
		
	```

	```objc
	
		// 设置显示的图片
		NSArray *imageNameArr = @[@"page_00", @"page_01", @"page_02", @"page_03", @"page_04"];
		    
		// 创建分页视图控件
		CGRect frame = CGRectMake(0, 50 + self.view.bounds.size.width / 2,
		                          self.view.bounds.size.width, self.view.bounds.size.width / 2);
		    
		QPageView *pageView = [QPageView q_pageViewWithFrame:frame
		                                          imageNames:imageNameArr
		                                          autoScroll:YES
		                                      autoScrollTime:3.0
		                               pageIndicatorPosition:Center];
		    
		[self.view addSubview:pageView];
    
	```

	- 效果

		![t_QExtension36](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension36.gif)

### 7.3 QTouchLockView methods

- 手势锁

	```objc
	
		// 设置 frame
		CGFloat margin = 50;
		CGFloat width = self.view.bounds.size.width - margin * 2;
		CGRect frame = CGRectMake(margin, 200, width, width);
		    
		// 创建手势锁视图界面，获取滑动结果
		QTouchLockView *touchLockView = [QTouchLockView q_touchLockViewWithFrame:frame
		                                                              pathResult:^(BOOL isSucceed, NSString * _Nonnull result) {
		    
		    // 处理手势触摸结果
		    [self dealTouchResult:result isSucceed:isSucceed];
		}];
		    
		[self.view addSubview:touchLockView];
    
	```

	```objc

		- (void)dealTouchResult:(NSString *)result isSucceed:(BOOL)isSucceed {
		    
		    // 处理手势触摸结果
		    
		    if (isSucceed) {
		        
		        // 判读密码是否存在
		        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
		        
		        if ([df objectForKey:@"touchLock"] == nil) {
		            
		            // 设置手势锁
		            
		            [self.passWordArrM addObject:result];
		            
		            if (self.passWordArrM.count == 1) {
		                self.touchLockView.alertLabel.text = @"请再设置一次";
		            }
		            
		            if (self.passWordArrM.count == 2) {
		                if ([self.passWordArrM[0] isEqualToString:self.passWordArrM[1]]) {
		                    
		                    // 存储密码
		                    [df setValue:self.passWordArrM[0] forKey:@"touchLock"];
		                    [df synchronize];
		                    
		                    self.touchLockView.alertLabel.text = @"手势密码设置成功";
		                    
		                } else {
		                    
		                    // 两次滑动结果不一致
		                    [self.passWordArrM removeAllObjects];
		                    
		                    self.touchLockView.alertLabel.text = @"两次滑动的结果不一致，请重新设置";
		                }
		            }
		            
		        } else {
		            
		            // 解锁
		            
		            if ([result isEqualToString:[df objectForKey:@"touchLock"] ]) {
		                self.touchLockView.alertLabel.text = @"解锁成功";
		            } else {
		                self.touchLockView.alertLabel.text = @"密码不正确，请重试";
		            }
		        }
		        
		    } else {
		        
		        // 滑动点数过少
		        self.touchLockView.alertLabel.text = result;
		    }
		}

	```

	- 效果

		![t_QExtension37](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension37.gif)


## 8、UIViewController Extension

### 8.1 QQRCode

- 创建二维码扫描视图控制器

	```objc
	
		// 创建二维码扫描视图控制器
		QQRCode *qrCode = [QQRCode q_qrCodeWithResult:^(BOOL isSucceed, NSString *result) {
		    
		    if (isSucceed) {
		        
		        [[[UIAlertView alloc] initWithTitle:@"Succeed"
		                                    message:result
		                                   delegate:nil
		                          cancelButtonTitle:@"确定"
		                          otherButtonTitles:nil] show];
		        
		    } else {
		        
		        [[[UIAlertView alloc] initWithTitle:@"Failed"
		                                    message:result
		                                   delegate:nil
		                          cancelButtonTitle:@"确定"
		                          otherButtonTitles:nil] show];
		    }
		}];
		    
		// 设置我的二维码信息
		qrCode.myQRCodeInfo = @"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X";
		qrCode.headIcon = [UIImage imageNamed:@"demo6"];
		    
		// 打开扫描视图控制器
		[self presentViewController:qrCode animated:YES completion:nil];
	
	```
	
	- 效果

		![t_QExtension39](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension39.PNG)  ![t_QExtension40](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension40.PNG)

		![t_QExtension41](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension41.PNG)  ![t_QExtension44](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension44.gif)

- 生成二维码

	```objc

		UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
		                                               headIcon:nil
		                                                  color:nil
		                                              backColor:nil];
		    
		UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:@"http://weixin.qq.com/r/xUqbg1-ENgJJrRvg9x-X"
		                                               headIcon:[UIImage imageNamed:@"demo6"]
		                                                  color:[UIColor blackColor]
		                                              backColor:[UIColor whiteColor]];

	```

	- 效果

		![t_QExtension32](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension32.png)  ![t_QExtension33](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension33.png)

- 识别二维码
	
	```objc
	
		// 创建图片，添加长按手势
		self.imageView.image = [UIImage imageNamed:@"demo4"];
		    
		UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dealLongPress:)];
		[self.imageView addGestureRecognizer:longPress];
	
		// 处理长按手势，识别图片中的二维码
		- (void)dealLongPress:(UIGestureRecognizer *)gesture {
		    
		    if (gesture.state == UIGestureRecognizerStateBegan) {
		        
		        UIImageView *pressedImageView = (UIImageView *)gesture.view;
		        UIImage *image = pressedImageView.image;
		        
		        // 识别图片中的二维码
		        NSString *result = [image q_stringByRecognizeQRCode];
		        
		        [[[UIAlertView alloc] initWithTitle:@"Succeed"
		                                    message:result
		                                   delegate:nil
		                          cancelButtonTitle:@"确定"
		                          otherButtonTitles:nil] show];
		    }
		}
	
	```

	- 效果

		![t_QExtension38](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension38.png)  ![t_QExtension34](http://images.cnblogs.com/cnblogs_com/QianChia/934664/t_QExtension34.gif)














