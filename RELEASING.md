# 发布维护

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.1","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.1"} -->

## 6.3.1

正式二进制来自提交 A `a20aa5786ed6d38bef3712ec38ac923209c8c30d`；发布元数据提交 B 为 `56af329df190a0babf386168ae625366b6d0502e`。两者不得混称二进制源码提交。当前版本的冻结库存与发布阶段以 `release-state.json` 为准。

## 正式发布唯一入口

使用私有源码仓的 `scripts/release-orchestrator.py`；构建、打包脚本仅作为底层门禁或故障诊断入口。

正式发布由私有源码仓的 `scripts/release-plan-ys-splash.json` 驱动，依次执行 `prepare → preflight → publish → verify → closeout`。提交 A 构建并签名，提交 B 仅回填 checksum 与发布元数据；`release-state.json` 记录冻结库存及最终消费证据。

上传资产精确为 `YSIFLYADLib-SplashOnly.xcframework.zip`、`YSIFLYADLib-SplashOnly-6.3.1.zip`、`checksums.txt`，禁止覆盖已有 Tag、Release 或资产。发布后必须匿名复验 SHA-256，并通过 SwiftPM、CocoaPods Demo 消费与 CLOSED 状态验证。

Apple Review 为主动可选扫描，未运行记录 `not-run`；CocoaPods trunk 不在范围内。
