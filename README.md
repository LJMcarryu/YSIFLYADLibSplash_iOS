# 萤石仅开屏 iOS SDK

## 6.4.4 候选

<!-- ifly-release-candidate: {"schemaVersion":1,"version":"6.4.4","releaseState":"CANDIDATE","publicationState":"UNPUBLISHED","repository":"LJMcarryu/YSIFLYADLibSplash_iOS","currentFormalVersion":"6.4.2"} -->

`6.4.4` 为候选，尚未发布；当前公开正式版和生产依赖保持 `6.4.2`。历史 Tag、Release 和资产保持不可变。


`YSIFLYADLibSplash` 为 iOS App 提供图片和视频开屏广告；本仓库包含分发清单、接入指南与示例。

当前正式版本：[`6.4.2`](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.2)。

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.4.2","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.2"} -->

[运行示例](YSIFLYADLibSimple/README.md) · [安装指南](docs/接入指南/安装与资源配置.md) · [广告接入](docs/接入指南/广告加载与展示.md) · [更新记录](CHANGELOG.md) · [隐私与网络](docs/接入指南/隐私与网络.md) · [支持](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/issues) · [许可](LICENSE)

## 能力与接入身份

| 项目 | 说明 |
| --- | --- |
| 广告能力 | 图片、视频开屏；不包含 Banner、插屏、自渲染信息流或激励广告 |
| CocoaPods / SwiftPM product | `YSIFLYADLibSplash` |
| 代码模块 / 导入 | `YSIFLYADLib` / `#import <YSIFLYADLib/YSIFLYADLib.h>` |
| 资源包 | `YSAdvSDK.bundle`，含 `PrivacyInfo.xcprivacy` |
| API 命名 | 类型使用 `YSIFLY` 前缀；公开方法和 delegate 回调使用 `ysifly_` 前缀，初始化方法和属性不加此前缀 |
| 共存限制 | 与多格式 `YSIFLYADLib` 使用相同模块、类型与资源，同一 App 只能选择一个 YS 包 |

迁移 YS 包时先移除旧依赖、手工 framework 和重复资源。接口以所安装版本的 framework 公开头为准。

## 环境要求

- iOS 11.0+；SwiftPM 清单要求 Swift tools 5.9。
- 静态 XCFramework，包含设备与模拟器切片；App 最终链接需要 `-ObjC`，无需 **Embed & Sign**。
- [环境与安装说明](docs/接入指南/安装与资源配置.md#环境要求)区分部署目标、清单要求与工具兼容范围。

## 安装

推荐 CocoaPods，使用精确版本的 Podspec URL：

```ruby
source 'https://cdn.cocoapods.org/'
platform :ios, '11.0'

target 'YourApp' do
  use_frameworks!
  pod 'YSIFLYADLibSplash',
      :podspec => 'https://raw.githubusercontent.com/LJMcarryu/YSIFLYADLibSplash_iOS/6.4.2/YSIFLYADLibSplash.podspec'
end
```

```bash
pod install
open YourApp.xcworkspace
```

该版本通过上述 URL 安装，无需依赖 CocoaPods trunk 收录。CocoaPods 自动加入资源、`-ObjC` 和所需系统库。

SwiftPM 或手动集成见[安装与资源配置](docs/接入指南/安装与资源配置.md)。三种方式选择一种；依赖名为 `YSIFLYADLibSplash`，代码始终导入 `YSIFLYADLib`。

## 最小使用流程

SDK 无需额外 App ID 初始化。完成宿主隐私流程，使用平台分配给当前 App 和广告形式的广告位，创建并强持有广告对象、设置 delegate，然后调用 `ysifly_loadAd`。开屏收到 Ready 后检查有效性、来源窗口与宿主展示时机，再调用展示方法；失败、结束或宿主放弃等待时继续业务并清理对象。成功展示后的下一次机会需新建对象。

完整普通请求示例、稍后展示与失败出口见[广告加载与展示](docs/接入指南/广告加载与展示.md)。

## 按广告形式接入

| 广告形式 | 接入指南 | 示例源码 |
| --- | --- | --- |
| 图片 / 视频开屏 | [加载、展示与回调](docs/接入指南/广告加载与展示.md#加载与展示) | [开屏页面](YSIFLYADLibSimple/YSIFLYADLibSimple/biz/splash/YSIFLYSplashViewController.m) |

普通广告无需服务端竞价；已开通媒体可查阅 [S2S 与 Header Bidding](docs/接入指南/竞价接入.md)。

## 隐私、支持与许可

`ysifly_setPersonalizedEnabled:` 仅记录状态，不改变数据处理、请求、填充、展示或点击行为，也不替代宿主同意流程与 ATT 授权。IDFA 只在授权后读取或传入；资源清单、ATS 与日志说明见[隐私与网络](docs/接入指南/隐私与网络.md)。

接入失败先查[错误处理与反馈](docs/接入指南/错误处理与反馈.md)；仍需帮助时通过 [Issues](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/issues) 提供版本、操作步骤、错误码和脱敏日志。使用许可见 [LICENSE](LICENSE)。

<details>
<summary>原章节入口</summary>

<a id="cocoapods"></a>

原“CocoaPods”内容见[对应指南](docs/接入指南/安装与资源配置.md#cocoapods)。

<a id="swift-package-manager"></a>

原“Swift Package Manager”内容见[对应指南](docs/接入指南/安装与资源配置.md#swift-package-manager)。

<a id="手动集成"></a>

原“手动集成”内容见[对应指南](docs/接入指南/安装与资源配置.md#手动集成)。

<a id="加载与展示"></a>

原“加载与展示”内容见[对应指南](docs/接入指南/广告加载与展示.md#加载与展示)。

<a id="展示配置与回调"></a>

原“展示配置与回调”内容见[对应指南](docs/接入指南/广告加载与展示.md#展示配置与回调)。

<a id="请求配置与竞价"></a>

原“请求配置与竞价”内容见[对应指南](docs/接入指南/竞价接入.md)。

<a id="资源隐私与网络"></a>

原“资源、隐私与网络”内容见[隐私与网络](docs/接入指南/隐私与网络.md)。

<a id="错误处理与常见问题"></a>

原“错误处理与常见问题”内容见[对应指南](docs/接入指南/错误处理与反馈.md)。

</details>
