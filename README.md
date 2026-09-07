# 萤石仅开屏 SDK

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.1","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.1"} -->

当前正式版本：[6.3.1](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.1)。

只保留图片、视频开屏；不包含 Banner、插屏、自渲染和激励广告。最低 iOS 11.0。

依赖坐标为 `YSIFLYADLibSplash`，模块仍为 `YSIFLYADLib`，公开类型为 `YSIFLY*`、方法为 `ysifly_*`。与原 YS 多格式包在同一 App 中互斥，迁移时先移除旧依赖及重复资源。

可选择 SwiftPM、Podspec URL 或手动接入。SwiftPM 选择产品 `YSIFLYADLibSplash`；CocoaPods 示例见 `YSIFLYADLibSimple/Podfile`，本仓不声明 CocoaPods trunk 已发布。

手动接入须同时加入 `YSIFLYADLib.xcframework` 和 `YSAdvSDK.bundle`；静态 framework 不 Embed，宿主链接参数加入 `-ObjC`，强链接 `AdSupport`，弱链接 `AppTrackingTransparency`。资源包包含隐私清单。SwiftPM 自动投递资源，宿主仍需配置 `-ObjC`。

使用 `#import <YSIFLYADLib/YSIFLYADLib.h>`。初始化后创建 `YSIFLYSplashAd` 并设置 delegate，调用 `ysifly_loadAd`；收到 `ysifly_splashAdDidReady:` 后展示。图片与视频共用入口，`hasVideoTemplate` 在加载成功后可读。完整示例见 `YSIFLYADLibSimple`。

正式产物、checksum 和源码溯源以 Release 与 `release-state.json` 为准。Apple Review 尚未运行，不代表宿主合规、真机联调或 Apple 审核已通过。
