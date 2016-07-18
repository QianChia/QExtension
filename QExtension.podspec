Pod::Spec.new do |s|
  s.name         = 'QExtension'
  s.version      = '1.0.0'
  s.ios.deployment_target = '7.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/QianChia/QExtension'
  s.authors      = {'QianChia' => 'jhqian0228@icloud.com'}
  s.summary      = 'The extension method for Foundation & UIKit Class'
  s.source       = {:git => 'https://github.com/QianChia/QExtension.git', :tag => s.version}
  s.source_files = 'QExtension'
  s.requires_arc = true
end
