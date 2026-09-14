# 萤石仅开屏 SDK

## 6.3.5 冻结与发布记录

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.5","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5"} -->

- `releaseState`：`FORMAL`
- `binarySourceCommit`（SDK 二进制源码提交）：`296111efe0762df5bb75f67efdda6d42752e048f`
- `releaseMetadataCommit`（仅回填 checksum、扫描汇总和发布验收事实，不是 SDK 二进制源码提交）：`9e11af8f51d87b280b72803053a7b5745e1d7535`
- `candidateId`：`2d31c748ad88474584a38409c84a28f39f96865ca40eff417fe14f2c4be6b463`

`6.3.5` 正式签名资产、checksum 和 A/B 元数据已经冻结。`release-state.json` 保存冻结库存与分发阶段；正式发布时间和消费回执以其中的 `publication` 字段及本版本 GitHub Release 为准。Apple Review 为 `not-run`；CocoaPods trunk 不在本次范围。

当前正式版本：[6.3.5](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5)。生产项目固定到具体版本；公开可用性以同版本 GitHub Release 和发布后 CI 为准。

上一正式版本：[6.3.1](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.1)。

只保留图片、视频开屏；不包含 Banner、插屏、自渲染和激励广告。最低 iOS 11.0。

依赖坐标为 `YSIFLYADLibSplash`，模块仍为 `YSIFLYADLib`，公开类型为 `YSIFLY*`、方法为 `ysifly_*`。与原 YS 多格式包在同一 App 中互斥，迁移时先移除旧依赖及重复资源。

可选择 SwiftPM、Podspec URL 或手动接入。SwiftPM 选择产品 `YSIFLYADLibSplash`；CocoaPods 示例见 `YSIFLYADLibSimple/Podfile`，本仓不声明 CocoaPods trunk 已发布。

手动接入须同时加入 `YSIFLYADLib.xcframework` 和 `YSAdvSDK.bundle`；静态 framework 不 Embed，宿主链接参数加入 `-ObjC`，强链接 `AdSupport`，弱链接 `AppTrackingTransparency`。资源包包含隐私清单。SwiftPM 自动投递资源，宿主仍需配置 `-ObjC`。

使用 `#import <YSIFLYADLib/YSIFLYADLib.h>`。初始化后创建 `YSIFLYSplashAd` 并设置 delegate，调用 `ysifly_loadAd`；收到 `ysifly_splashAdDidReady:` 后展示。图片与视频共用入口，`hasVideoTemplate` 在加载成功后可读。完整示例见 `YSIFLYADLibSimple`。

正式产物、checksum 和源码溯源以 Release 与 `release-state.json` 为准。Apple Review 尚未运行，不代表宿主合规、真机联调或 Apple 审核已通过。
