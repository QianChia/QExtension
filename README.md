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

### NSString Extension

* BundlePath methods

	```objc
	
		NSString *filePath = @"~/Desktop/file.txt";
    
		NSString *documentPath = [filePath q_appendDocumentPath];
   	
		NSString *cachePath = [filePath q_appendCachePath];
    	
		NSString *tempPath = [filePath q_appendTempPath];
   	
		NSString *md5DocumentPath = [filePath q_appendMD5DocumentPath];
   	
		NSString *md5CachePath = [filePath q_appendMD5CachePath];
    	
		NSString *md5TempPath = [filePath q_appendMD5TempPath];
		
	```
	
* Base64 methods 

	```objc
	
		NSString *str = @"hello world";
    
    	NSString *base64Str = [str q_base64Encode];
   	
    	NSString *asciiStr = [base64Str q_base64Decode];
   	
    	NSString *authStr = [str q_basic64AuthEncode];
    	
	```
	
* Hash methods 

	```objc
	
    	NSString *str = @"hello world";
    	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    	NSString *md5Str = [str q_md5String];
  	
    	NSString *hmacStr = [str q_hmacMD5StringWithKey:@"yourKey"];
   	
    	NSString *timeStr = [str q_timeMD5StringWithKey:@"yourKey"];
    	
    	NSString *fileMD5Str = [filePath q_fileMD5Hash];
    	
	```
	
* Regex methods 

	```objc
	
    	NSString *mobileNum = @"15188886666";
    	BOOL isValidMobileNum = [mobileNum q_isValidMobileNum];
		
    	NSString *emailAddress = @"qianchia@icloud.com";
    	BOOL isValidEmailAddress = [emailAddress q_isValidEmailAddress];
    	
	```

### NSData Extension

- FormData methods

	- Single File Upload

		```objc
	
        	#define boundary @"uploadBoundary"
        
        	NSMutableData *formDataM = [NSMutableData data];
        
        	[formDataM q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
        
        	[formDataM q_appendPartWithFileURL:fileURL 
        	                      fileBoundary:boundary 
        	                              name:@"userfile" 
        	                          fileName:@"test1.png" 
        	                          mimeType:@"image/png"];
        
        	[formDataM q_appendPartWithText:@"qian" textName:@"username" fileBoundary:boundary];
        
        	[formDataM q_appendPartEndingWithFileBoundary:boundary];
    
		```	

		```objc
	
			NSData *formData = [NSData q_formDataWithRequest:request 
			                                            text:@"qian" 
			                                        textName:@"username" 
			                                        fileData:filedata 
			                                            name:@"userfile" 
			                                        fileName:@"test2.png" 
			                                        mimeType:@"image/png"];
		
		```
	- Multiple File Upload

		```objc
		
        	NSData *formData = [NSData q_formDataWithRequest:request
        	                                       fileDatas:@[filedata1, filedata2]
        	                                            name:@"userfile[]"
        	                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
        	                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
		``` 
		
		```objc
		
        	NSData *formData = [NSData q_formDataWithRequest:request
        	                                           texts:@[@"qian"]
        	                                       textNames:@[@"username"]
        	                                       fileDatas:@[filedata1, filedata2]
        	                                            name:@"userfile[]"
        	                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"]
        	                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    
		``` 
	
		```objc
		
    		NSData *formData = [NSData q_formDataWithRequest:request 
    		                                        fileURLs:@[fileURL1, fileURL2] 
    		                                            name:@"userfile[]" 
    		                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] 
    		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    	
		``` 
	
		```objc
		
    		NSData *formData = [NSData q_formDataWithRequest:request 
    		                                           texts:@[@"qian"] 
    		                                       textNames:@[@"username"] 
    		                                        fileURLs:@[fileURL1, fileURL2] 
    		                                            name:@"userfile[]" 
    		                                       fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] 
    		                                       mimeTypes:@[@"image/png", @"image/jpeg"]];
    	
		``` 

### UIButton Extension

* Progress methods

	```objc

		[button q_setButtonWithProgress:0.5 lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];
	
	```
	
### UIImage Extension

* GIF methods
	
	```objc
	
		/// 通过名称加载 gif 图片
		+ (UIImage *)q_gifImageNamed:(NSString *)name;
		
		/// 通过数据加载 gif 图片
		+ (UIImage *)q_gifImageWithData:(NSData *)data;
		
		/// 缩放裁剪图片尺寸到指定大小
		- (UIImage *)q_gifImageByScalingAndCroppingToSize:(CGSize)size;
	
	```
	
	
	```objc

    	// 加载 gif 动图，不需要写扩展名
    	imageView.image = [UIImage q_gifImageNamed:@"demo3"];
	
	```

### UIView Extension

* UIView methods
 
	```objc
	
		// 直接设置控件的位置尺寸值
		    
		view.x = 20;
		view.y = 200;
		view.width = 200;
		view.height = 100;
		    
		view.centerX = 160;
		view.centerY = 300;
		    
		view.size = CGSizeMake(100, 200);
	
	```
	
* QPageView methods
 	
	```objc
	
		// 创建分页视图控件方式
		
    	QPageView *pageView = [[QPageView alloc] init];
    
    	QPageView *pageView = [[QPageView alloc] initWithFrame:CGRectMake(0, 20, 300, 150)];
    
    	QPageView *pageView = [QPageView q_pageView];
    
    	QPageView *pageView = [QPageView q_pageViewWithImageNames:@[@"img_00", @"img_01", @"img_02"]
    	                                               autoScroll:YES
    	                                           autoScrollTime:2.0
    	                                    pageIndicatorPosition:Right];
		
	```

	```objc
	
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
    
	```

	```objc
	
    	// 设置显示的图片
    	NSArray *imageNameArr = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    
    	// 创建分页视图控件
    	QPageView *pageView = [QPageView q_pageViewWithImageNames:imageNameArr
    	                                               autoScroll:YES
    	                                           autoScrollTime:1.0
    	                                    pageIndicatorPosition:Center];
    
    	pageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2);
    
	```

* QQRCode methods
 
 	- 扫描二维码

		```objc
		
			// 创建并开始扫描二维码
			QQRCode *qrCode = [QQRCode q_scanQRCode:^(BOOL isSucceed, NSString *result) {
			    
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
			qrCode.myQRCodeInfo = @"qianchia";
			qrCode.headIcon = [UIImage imageNamed:@"demo5"];
			
			// 打开扫描视图控制器
			[self presentViewController:qrCode animated:YES completion:nil];
		
		```
		
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
			        NSString *result = [image q_recognizeQRCode];
			        
			        [[[UIAlertView alloc] initWithTitle:@"Succeed"
			                                    message:result
			                                   delegate:nil
			                          cancelButtonTitle:@"确定"
			                          otherButtonTitles:nil] show];
			    }
			}
		
		```
		
	- 生成二维码
		
		```objc
		
			// 生成二维码
			UIImage *qrImage = [UIImage q_createQRCodeFromString:@"qianchia"
			                                            headIcon:nil
			                                               color:nil
			                                           backColor:nil];
			
			self.imageView.image = qrImage;
		
		```

		```objc
		
			// 生成二维码
			UIImage *qrImage = [UIImage q_createQRCodeFromString:@"qianchia"
			                                            headIcon:[UIImage imageNamed:@"demo5"]
			                                               color:[UIColor redColor]
			                                           backColor:[UIColor blueColor]];
			    
			self.imageView.image = qrImage;
		
		```

### NSArray Extension

* NSLog methods

	`- (NSString *)descriptionWithLocale:(id)locale;`
	
### NSDictionary Extension

* NSLog methods

	`- (NSString *)descriptionWithLocale:(id)locale;`

