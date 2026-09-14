# 发布维护

## 6.3.5 冻结与发布记录

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.5","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5"} -->

- `releaseState`：`FORMAL`
- `binarySourceCommit`（SDK 二进制源码提交）：`296111efe0762df5bb75f67efdda6d42752e048f`
- `releaseMetadataCommit`（仅回填 checksum、扫描汇总和发布验收事实，不是 SDK 二进制源码提交）：`9e11af8f51d87b280b72803053a7b5745e1d7535`
- `candidateId`：`2d31c748ad88474584a38409c84a28f39f96865ca40eff417fe14f2c4be6b463`

`6.3.5` 正式签名资产、checksum 和 A/B 元数据已经冻结。`release-state.json` 保存冻结库存与分发阶段；正式发布时间和消费回执以其中的 `publication` 字段及本版本 GitHub Release 为准。Apple Review 为 `not-run`；CocoaPods trunk 不在本次范围。

冻结三资产的校验值：

| 资产 | SHA-256 |
| --- | --- |
| `YSIFLYADLib-SplashOnly.xcframework.zip` | `ca39b32c4b5c2404f79b9ce7645479683a7307d6b802caea8e47e02ac3a1e886` |
| `YSIFLYADLib-SplashOnly-6.3.5.zip` | `da2137c344ec6ddf7a2fbc1d9ba0d03a004f1e9e074d74f5ddeec1dbbdaaa449` |
| `checksums.txt` | `536536b2f1d4c5ff3e72ba4dab4244f86f8eff6dee502adbc96c2f16abb634a4` |

XCFramework zip 的 SwiftPM checksum 与上表 SHA-256 相同。

## 6.3.1 历史发布状态

正式二进制来自提交 A `a20aa5786ed6d38bef3712ec38ac923209c8c30d`；发布元数据提交 B 为 `56af329df190a0babf386168ae625366b6d0502e`。两者不得混称二进制源码提交。该历史版本的冻结库存与发布阶段见对应 Tag 的 `release-state.json`。

## 正式发布唯一入口

使用私有源码仓的 `scripts/release-orchestrator.py`；构建、打包脚本仅作为底层门禁或故障诊断入口。

正式发布由私有源码仓的 `scripts/release-plan-ys-splash.json` 驱动，依次执行 `prepare → preflight → publish → verify → closeout`。提交 A 构建并签名，提交 B 仅回填 checksum 与发布元数据；`release-state.json` 记录冻结库存及最终消费证据。

上传资产精确为 `YSIFLYADLib-SplashOnly.xcframework.zip`、`YSIFLYADLib-SplashOnly-6.3.5.zip`、`checksums.txt`，禁止覆盖已有 Tag、Release 或资产。发布后必须匿名复验 SHA-256，并通过 SwiftPM、CocoaPods Demo 消费与 CLOSED 状态验证。

Apple Review 为主动可选扫描，未运行记录 `not-run`；CocoaPods trunk 不在范围内。
