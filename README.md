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

### BundlePath methods

	```objc
	
		NSString *filePath = @"~/Desktop/file.txt";
    
		NSString *documentPath = [filePath q_appendDocumentPath];
   	
		NSString *cachePath = [filePath q_appendCachePath];
    	
		NSString *tempPath = [filePath q_appendTempPath];
   	
		NSString *md5DocumentPath = [filePath q_appendMD5DocumentPath];
   	
		NSString *md5CachePath = [filePath q_appendMD5CachePath];
    	
		NSString *md5TempPath = [filePath q_appendMD5TempPath];
	```
### Base64 methods 

	```objc
  		NSString *str = @"hello world";
    
    	NSString *base64Str = [str q_base64Encode];
   	
    	NSString *asciiStr = [base64Str q_base64Decode];
   	
    	NSString *authStr = [str q_basic64AuthEncode];
	```
### Hash methods 

	```objc
    	NSString *str = @"hello world";
    	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    
    	NSString *md5Str = [str q_md5String];
  	
    	NSString *hmacStr = [str q_hmacMD5StringWithKey:@"yourKey"];
   	
    	NSString *timeStr = [str q_timeMD5StringWithKey:@"yourKey"];
    	
    	NSString *fileMD5Str = [filePath q_fileMD5Hash];
	```
### FormData methods

- Single File Upload

	```objc
	
        #define boundary @"uploadBoundary"
        
        NSMutableData *formDataM = [NSMutableData data];
        
        [formDataM q_setHttpHeaderFieldWithRequest:request fileBoundary:boundary];
        
        [formDataM q_appendPartWithFileURL:fileURL fileBoundary:boundary name:@"userfile" fileName:@"test1.png" mimeType:@"image/png"];
        
        [formDataM q_appendPartWithText:@"qian" textName:@"username" fileBoundary:boundary];
        
        [formDataM q_appendPartEndingWithFileBoundary:boundary];
    
	```	
- or
			
	```objc
	
		NSData *formData = [NSData q_formDataWithRequest:request text:@"qian" textName:@"username" fileData:filedata name:@"userfile" fileName:@"test2.png" mimeType:@"image/png"];
	
	```
- Multiple File Upload

	```objc
	
    	NSData *formData = [NSData q_formDataWithRequest:request texts:@[@"qian"] textNames:@[@"username"] fileURLs:@[fileURL1, fileURL2] name:@"userfile[]" fileNames:@[@"demoFile1.png", @"demoFile2.jpg"] mimeTypes:@[@"image/png", @"image/jpeg"]];
    	
	``` 
	
### Progress methods

	```objc

		[button q_setButtonWithProgress:0.5 lineWidth:10 lineColor:nil backgroundColor:[UIColor yellowColor]];	
	
	```
