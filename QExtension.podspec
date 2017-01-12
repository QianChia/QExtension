Pod::Spec.new do |s|
  s.name         = 'QExtension'
  s.version      = '1.1.0'
  s.license      = 'MIT'
  s.authors      = {'QianChia' => 'qianchia@icloud.com'}
  s.summary      = 'The extension method for Foundation & UIKit Class'
  s.homepage     = 'https://github.com/QianChia/QExtension'
  s.source       = {:git => 'https://github.com/QianChia/QExtension.git', :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.source_files        = 'QExtension/QExtension.h'
  s.public_header_files = 'QExtension/QExtension.h'

  s.subspec 'NSArray+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSArray+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/NSArray+QExtension/NSArray+QExtension.h'
  end

  s.subspec 'NSData+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSData+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/NSData+QExtension/NSData+QExtension.h'
  end

  s.subspec 'NSDictionary+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSDictionary+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/NSDictionary+QExtension/NSDictionary+QExtension.h'
  end

  s.subspec 'NSString+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSString+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/NSString+QExtension/NSString+QExtension.h'
  end

  s.subspec 'UIButton+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIButton+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/UIButton+QExtension/UIButton+QExtension.h'
  end

  s.subspec 'UIImage+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIImage+QExtension/*.{h,m}'
    ss.public_header_files  = 'QExtension/UIImage+QExtension/UIImage+QExtension.h'
  end

  s.subspec 'UIView+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIView+QExtension/*.{h,m,bundle}'
    ss.public_header_files  = 'QExtension/UIView+QExtension/UIView+QExtension.h'
  end

  s.subspec 'UIViewController+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIViewController+QExtension/*.{h,m,bundle}'
    ss.public_header_files  = 'QExtension/UIViewController+QExtension/UIViewController+QExtension.h'
  end

end
