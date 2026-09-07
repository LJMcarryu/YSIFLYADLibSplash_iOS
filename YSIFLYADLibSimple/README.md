# 仅开屏接入示例

版本 `6.3.1` 首发准备中。仅演示图片、视频开屏，不编译其他广告形式。

发布后执行 `pod install`，通过生成的 `YSIFLYADLibSimple.xcworkspace` 打开工程。填入媒体授权的 app ID 和开屏广告位后联调；示例 ID 不保证真实填充。

依赖为 `YSIFLYADLibSplash`，导入模块仍为 `YSIFLYADLib`。同 App 不得同时安装旧 YS 包。加载成功不等于素材就绪，应在 `ysifly_splashAdDidReady:` 后展示；页面结束时调用 `ysifly_destroy`。
