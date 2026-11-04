# 发布维护

## 6.4.4 冻结与发布记录

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.4.4","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.4"} -->

`6.4.4` 的正式分发资料以同版本真实冻结 manifest 为准。当前正式版本：[`6.4.4`](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.4.4)；公开时间和消费验证结论以 `release-state.json.publication` 与同版本 GitHub Release 的实际状态为准。历史 Tag、Release 和资产保持不可变。


## 6.4.2 冻结与发布记录

历史记录见[历史发布记录](docs/需求设计/发布验收/历史发布记录.md#642-冻结与发布记录)。

## 6.4.1 冻结与发布记录

历史记录见[历史发布记录](docs/需求设计/发布验收/历史发布记录.md#641-冻结与发布记录)。

## 6.4.0 冻结与发布记录

历史记录见[历史发布记录](docs/需求设计/发布验收/历史发布记录.md#640-冻结与发布记录)。

## 6.3.5 冻结与发布记录

历史记录见[历史发布记录](docs/需求设计/发布验收/历史发布记录.md#635-冻结与发布记录)。

## 6.3.1 历史发布状态

历史记录见[历史发布记录](docs/需求设计/发布验收/历史发布记录.md#631-历史发布状态)。

## 正式发布唯一入口

使用私有源码仓的 `scripts/release-orchestrator.py`；构建、打包脚本仅作为底层门禁或故障诊断入口。

正式发布由私有源码仓的 `scripts/release-plan-ys-splash.json` 驱动，依次执行 `prepare → preflight → publish → verify → closeout`。提交 A 构建并签名，提交 B 仅回填 checksum 与发布元数据；`release-state.json` 记录冻结库存及最终消费证据。

上传资产精确为 `YSIFLYADLib-SplashOnly.xcframework.zip`、`YSIFLYADLib-SplashOnly-<目标版本>.zip`、`checksums.txt`，禁止覆盖已有 Tag、Release 或资产。发布后必须匿名复验 SHA-256，并通过 SwiftPM、CocoaPods Demo 消费与 CLOSED 状态验证。

Apple Review 为主动可选扫描，未运行记录 `not-run`；CocoaPods trunk 不在范围内。
