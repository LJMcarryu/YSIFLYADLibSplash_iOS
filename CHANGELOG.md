# 变更记录

## 6.3.5（2026-09-14）

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.5","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5"} -->

- `releaseState`：`FORMAL`
- `binarySourceCommit`（SDK 二进制源码提交）：`296111efe0762df5bb75f67efdda6d42752e048f`
- `releaseMetadataCommit`（仅回填 checksum、扫描汇总和发布验收事实，不是 SDK 二进制源码提交）：`9e11af8f51d87b280b72803053a7b5745e1d7535`
- `candidateId`：`2d31c748ad88474584a38409c84a28f39f96865ca40eff417fe14f2c4be6b463`

`6.3.5` 正式签名资产、checksum 和 A/B 元数据已经冻结。`release-state.json` 保存冻结库存与分发阶段；正式发布时间和消费回执以其中的 `publication` 字段及本版本 GitHub Release 为准。Apple Review 为 `not-run`；CocoaPods trunk 不在本次范围。

## 6.3.1

首发独立图片/视频仅开屏发行包，采用 YS 品牌与 `SplashVideo` 整变体。纳入源码基线 `90da9847084b398f2cda5469f3928831f968721f` 的开屏初始化和 S2S 性能优化；二进制提交 A 为 `a20aa5786ed6d38bef3712ec38ac923209c8c30d`，发布元数据提交 B 为 `56af329df190a0babf386168ae625366b6d0502e`。该坐标与原 YS 同号版本不是同一二进制。

SDK 1279 项（9 跳过）、Demo 141 项、发布脚本 432 项及全部变体行为门禁均无失败。移除非开屏格式入口和实现，保留视频播放、缓存、监测、竞价和必要资源。真机和真实媒体联调未执行，Apple Review 为 `not-run`。
