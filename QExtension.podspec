Pod::Spec.new do |s|
  s.name         = 'QExtension'
  s.version      = '1.1.7'
  s.license      = 'MIT'
  s.authors      = {'QianChia' => 'qianchia@icloud.com'}
  s.summary      = 'The extension method for Foundation & UIKit Class'
  s.homepage     = 'https://github.com/QianChia/QExtension'
  s.source       = {:git => 'https://github.com/QianChia/QExtension.git', :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.source_files        = 'QExtension/QExtension.h'
  s.public_header_files = 'QExtension/QExtension.h'

  s.subspec 'NSObject+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSObject+QExtension/*.{h,m}'
  end

  s.subspec 'NSArray+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSArray+QExtension/*.{h,m}'
  end

  s.subspec 'NSData+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSData+QExtension/*.{h,m}'
  end

  s.subspec 'NSDictionary+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSDictionary+QExtension/*.{h,m}'
  end

  s.subspec 'NSString+QExtension' do |ss|
    ss.source_files         = 'QExtension/NSString+QExtension/*.{h,m}'
  end

  s.subspec 'UIButton+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIButton+QExtension/*.{h,m}'
  end

  s.subspec 'UIColor+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIColor+QExtension/*.{h,m}'
  end

  s.subspec 'UIImage+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIImage+QExtension/*.{h,m}'
  end

  s.subspec 'UILabel+QExtension' do |ss|
    ss.source_files         = 'QExtension/UILabel+QExtension/*.{h,m}'
  end

  s.subspec 'UIView+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIView+QExtension/*.{h,m}'
    ss.resource             = 'QExtension/UIView+QExtension/*.bundle'
  end

  s.subspec 'UIViewController+QExtension' do |ss|
    ss.source_files         = 'QExtension/UIViewController+QExtension/*.{h,m}'
    ss.resource             = 'QExtension/UIViewController+QExtension/*.bundle'
  end

end
