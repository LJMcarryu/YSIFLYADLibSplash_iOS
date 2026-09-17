# 变更记录

## 6.3.6 候选（待联调）

<!-- ifly-release-candidate: {"schemaVersion":1,"version":"6.3.6","releaseState":"CANDIDATE","publicationState":"UNPUBLISHED","repository":"LJMcarryu/YSIFLYADLibSplash_iOS","currentFormalVersion":"6.3.5"} -->

`6.3.6` 尚未发布，本节仅记录待联调候选行为。当前公开正式版仍为 `6.3.5`；既有 Tag、Release 和资产保持不可变。

### 变更

- 共享 UIScene 适配：展示、落地页、外跳回流、曝光判断和 UI 生命周期使用广告的实际来源 window/Scene；完全没有来源时，只允许唯一且明确的前台应用 Scene，不跨 Scene 随机兜底。独立落地页始终归属来源 Scene。
- 收紧开屏 `customWindow` 的 Scene 宿主验收：rootVC 仍须入窗；`customWindow` 必须可见、尺寸有限且为正、已关联 Scene，并与 `rootVC.window` 同 Scene。合法窗口可以不是 key window，可以使用较高 `windowLevel`，也可以没有 rootVC。
- 无 Scene、跨 Scene、隐藏或尺寸无效的 `customWindow` 会导致展示失败；失败不锁死本次机会，媒体修正后可以重试。
- 公开 API 方法签名不变。

## 6.3.5（2026-09-14）

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.5","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5"} -->

正式发布于 2026-09-14；本版本的消费结果见 [RELEASING](RELEASING.md)。历史章节只描述各自版本，不替代当前接入契约。

- `releaseState`：`FORMAL`
- `binarySourceCommit`（SDK 二进制源码提交）：`296111efe0762df5bb75f67efdda6d42752e048f`
- `releaseMetadataCommit`（仅回填 checksum、扫描汇总和发布验收事实，不是 SDK 二进制源码提交）：`9e11af8f51d87b280b72803053a7b5745e1d7535`
- `candidateId`：`2d31c748ad88474584a38409c84a28f39f96865ca40eff417fe14f2c4be6b463`

`6.3.5` 正式签名资产、checksum 和 A/B 元数据已经冻结。`release-state.json` 保存冻结库存与分发阶段；正式发布时间和消费回执以其中的 `publication` 字段及本版本 GitHub Release 为准。Apple Review 为 `not-run`；CocoaPods trunk 不在本次范围。

### 变更

- 同步开屏加载代次与回调保护，修复全交互回流、视频暂停恢复和完播边界。
- 展示终态清理 SDK 自有 Window 容器，曝光提交后停止检测；共享图片下载支持订阅独立取消。
- 加强日志脱敏与 Release 裁剪，Debug 阶段时间线不进入正式包；保留图片和视频开屏，不新增其他格式。

## 6.3.1

首发独立图片/视频仅开屏发行包，采用 YS 品牌与 `SplashVideo` 整变体。纳入源码基线 `90da9847084b398f2cda5469f3928831f968721f` 的开屏初始化和 S2S 性能优化；二进制提交 A 为 `a20aa5786ed6d38bef3712ec38ac923209c8c30d`，发布元数据提交 B 为 `56af329df190a0babf386168ae625366b6d0502e`。该坐标与原 YS 同号版本不是同一二进制。

SDK 1279 项（9 跳过）、Demo 141 项、发布脚本 432 项及全部变体行为门禁均无失败。移除非开屏格式入口和实现，保留视频播放、缓存、监测、竞价和必要资源。真机和真实媒体联调未执行，Apple Review 为 `not-run`。
