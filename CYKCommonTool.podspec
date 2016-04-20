Pod::Spec.new do |s|
s.name             = "CYKCommonTool"
s.version          = "1.0.0"
s.summary          = "some common tools used on iOS."
s.description      = <<-DESC
It is a marquee view used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/jkyhsx/iOS_common"
# s.screenshots      = ""
s.license          = 'MIT'
s.author           = { "chenyuekai" => "630568109@qq.com" }
s.source           = { :git => "https://github.com/jkyhsx/iOS_common.git", :tag => s.version.to_s }
# s.social_media_url = ''

s.platform     = :ios, '7.0'
# s.ios.deployment_target = '7.0'
# s.osx.deployment_target = '10.11.4'
s.requires_arc = true

s.source_files = 'CYKCommonTool/*'
# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end