# 变更记录

## [6.5.0] - 更新说明

> `6.5.0` 已验证 CocoaPods、SwiftPM 的安装、版本锁定与模拟器构建；真机广告展示需在宿主 App 中联调。

<!-- ifly-release-status: {"version":"6.5.0","status":"FAST_UNVERIFIED","distribution":"tos","releaseUrl":"https://download-adsdk.voiceads.cn/ios_sdk/6.5.0/ys-splash/fast-release-record.json"} -->

> 以下为历史版本记录，验收结论仅适用于各节明确列出的历史版本。

## [6.4.6] - TOS 分发

本版 SDK 二进制改由火山云 TOS 分发，下载基础地址为 `https://download-adsdk.voiceads.cn/ios_sdk/6.4.6/ys-splash`。SwiftPM 与 CocoaPods 的公开版本入口保持，生产项目固定 `6.4.6`。

下载文件与校验值见[版本下载记录](https://download-adsdk.voiceads.cn/ios_sdk/6.4.6/ys-splash/release-record.json)。

> 以下为历史版本记录，其中当前版本和验收结论仅适用于各自历史版本。

## [6.4.4] - 发布工程优化

历史版本：[`6.4.4`](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.4)

### 变更

- 全渠道统一为 `6.4.4`，从同一共享源码重新构建，公开 API 方法签名、广告能力和最低 iOS 11.0 要求保持。

## [6.4.2] - 冻结与发布记录

> 以下为 `6.4.2` 历史记录；其中“当前”“本版”均只指该历史版本。

历史版本：[`6.4.2`](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.2)

## 6.4.1 - 发布工程优化

> 以下为 `6.4.1` 历史记录；其中“当前”“本版”均只指该历史版本。

历史版本：[Release 6.4.1](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.1)

### 变更

- 增加匿名逐资产恢复、正式 consumer 受控恢复、摘要日志和运行耗时证据。
- SDK 与 UI 行为继承 `6.4.0`，没有新增公开 API。

## 6.4.0 冻结与发布记录

历史版本：[Release 6.4.0](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.0)

### 变更

- 共享 UIScene 适配：展示、落地页、外跳回流、曝光判断和 UI 生命周期使用广告的实际来源 window/Scene；完全没有来源时，只允许唯一且明确的前台应用 Scene，不跨 Scene 随机兜底。独立落地页始终归属来源 Scene。
- 收紧开屏 `customWindow` 的 Scene 宿主验收：rootVC 仍须入窗；`customWindow` 必须可见、尺寸有限且为正、已关联 Scene，并与 `rootVC.window` 同 Scene。合法窗口可以不是 key window，可以使用较高 `windowLevel`，也可以没有 rootVC。
- 无 Scene、跨 Scene、隐藏或尺寸无效的 `customWindow` 会导致展示失败；失败不锁死本次机会，媒体修正后可以重试。
- 公开 API 方法签名不变。

## 6.3.5（2026-09-14）

正式发布于 2026-09-14；本版本的消费结果见 [RELEASING](RELEASING.md)。历史章节只描述各自版本，不替代当前接入契约。

- `releaseState`：`FORMAL`

`6.3.5` 正式签名资产、checksum 和 A/B 元数据已经冻结。`release-state.json` 保存冻结库存与分发阶段；正式发布时间和消费回执以其中的 `publication` 字段及本版本 GitHub Release 为准。Apple Review 为 `not-run`；CocoaPods trunk 不在本次范围。

### 变更

- 同步开屏加载代次与回调保护，修复全交互回流、视频暂停恢复和完播边界。
- 展示终态清理 SDK 自有 Window 容器，曝光提交后停止检测；共享图片下载支持订阅独立取消。
- 加强日志脱敏与 Release 裁剪，Debug 阶段时间线不进入正式包；保留图片和视频开屏，不新增其他格式。

## 6.3.1

SDK 1279 项（9 跳过）、Demo 141 项、发布脚本 432 项及全部变体行为门禁均无失败。移除非开屏格式入口和实现，保留视频播放、缓存、监测、竞价和必要资源。真机和真实媒体联调未执行，Apple Review 为 `not-run`。
