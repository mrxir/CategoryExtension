Pod::Spec.new do |s|
s.name     = 'CategoryExtension'
s.version  = '1.0.0'
s.ios.deployment_target = '8.0'
s.license  =  { :type => 'MIT', :file => 'LICENSE.txt' }
s.summary  = 'Log'
s.homepage = 'https://github.com/mrxir/CategoryExtension.git'
s.authors   = { 'Tangxi' => '100885521@qq.com' }
s.source   = { :git => 'https://github.com/mrxir/CategoryExtension.git', :tag => "1.0.0" }
s.description = '多个常用类的扩展'
s.source_files = 'CategoryExtension/**/*.{h,m}'
s.framework    = 'UIKit'
s.requires_arc = true
end
