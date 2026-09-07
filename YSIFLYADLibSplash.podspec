Pod::Spec.new do |s|
  s.name     = 'YSIFLYADLibSplash'
  s.version  = '6.3.1'
  s.summary  = '萤石 YS 图片和视频仅开屏广告 SDK。'
  s.homepage = 'https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS'
  s.author   = { 'LJMcarryu' => 'jmliu6@iflytek.com' }
  s.source   = { :http => 'https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/download/6.3.1/YSIFLYADLib-SplashOnly-6.3.1.zip' }
  s.license  = { :type => 'MIT', :file => 'LICENSE' }

  # iOS 11 声明只可随重新构建并验证过的新版本二进制发布；不得套用到旧 release 产物。
  s.platform = :ios, '11.0'
  s.static_framework = true
  s.vendored_frameworks = 'YSIFLYADLib.xcframework'
  s.resources = ['YSAdvSDK.bundle']
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
  # 静态 XCFramework 最终由宿主 App 链接，必须把 -ObjC 传播到 aggregate/user target。
  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
  s.frameworks = 'AdSupport'
  # iOS 14 起使用 ATT；弱链接保证 iOS 11～13 不要求该系统 framework 存在。
  s.weak_frameworks = 'AppTrackingTransparency'
end
