# YS 仅开屏接入示例

`6.4.1` 当前为发布前候选，尚未发布。当前公开正式版仍为 `6.4.0`；历史 Tag、Release 和资产保持不可变。本候选说明不改变示例当前使用的 SDK 版本。

本工程使用 `YSIFLYADLibSplash 6.4.0`，演示图片与视频开屏的加载、展示、跳过、关闭和资源释放。依赖名称为 `YSIFLYADLibSplash`，代码仍导入 `<YSIFLYADLib/YSIFLYADLib.h>`。

仅开屏 SDK 与多格式 `YSIFLYADLib` 使用相同模块和资源，不可同时加入同一 App。完整安装说明见[SDK 接入说明](../README.md)。

> 本示例的 `Podfile` 固定正式版本 `6.4.0`。版本公开状态与消费验证结论以 `release-state.json.publication` 和同版本 GitHub Release 的实际状态为准。
>
> `6.4.0` 的公开 API 方法签名不变。展示、落地页、外跳回流、曝光判断和 UI 生命周期应归属广告的实际来源 window/Scene；无来源时只允许唯一且明确的前台应用 Scene，不跨 Scene 随机兜底，独立落地页始终属于来源 Scene。开屏 rootVC 仍须入窗；Scene 宿主的 `customWindow` 必须可见、尺寸有限且为正、已关联 Scene，并与 `rootVC.window` 同 Scene，可以是非 key、高 `windowLevel`、无 rootVC。非法输入展示失败，修正后可以重试。

## 从下载到运行

准备 macOS、Xcode、CocoaPods 和可访问 GitHub Releases 的网络。最低部署目标为 iOS 11.0。使用模拟器可检查安装、链接和页面；真实广告填充、跳转和 ATT 请用真机联调。

```bash
git clone https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS.git
cd YSIFLYADLibSplash_iOS/YSIFLYADLibSimple
pod install
open YSIFLYADLibSimple.xcworkspace
```

1. 在 Xcode 选择 `YSIFLYADLibSimple` scheme 和模拟器或已连接的 iPhone。
2. 真机运行前，在 App target 的 **Signing & Capabilities** 选择自己的 Team；必要时将 Bundle Identifier 改为自己的标识。
3. 按下文替换广告位，确认后台授权的 App 信息与当前 App 一致，然后运行。
4. 首页应显示 `SDK Version: 6.4.0`。示例的 `Podfile` 固定使用正式版 `6.4.0`，示例页面可以随本仓库更新。

使用 CocoaPods 后始终打开 `.xcworkspace`。它自动加入 `YSAdvSDK.bundle`（含隐私清单）和 `-ObjC`；不需再手工嵌入静态 framework。其他安装方式见[SDK 接入说明](../README.md#安装)。

## 配置广告位与请求

打开 [`YSIFLYAdPrefixHeader.pch`](YSIFLYADLibSimple/Supporting%20Files/YSIFLYAdPrefixHeader.pch)，将需要体验的宏替换为媒体获分配的广告位 ID。仓库内的示例 ID 不保证填充；图片、视频等结果以广告位配置和实际返回为准。

| 宏 | 对应页面/选项 |
| --- | --- |
| `__SPLASH_NATIVE_AD_UNIT_ID__` | 图片开屏 |
| `__SPLASH_VIDEO_AD_UNIT_ID__` | 视频开屏 |

公共请求参数在 [`YSIFLYADUtil.m`](YSIFLYADLibSimple/Supporting%20Files/YSIFLYADUtil.m) 的 `mediaSampleRequestConfig` 中：示例超时为 5 秒，`settleType = @1`、`bidFloor = @0.01`、`interactStatus = @1`。这些是演示值，业务接入请按平台约定调整，勿将示例价格作为正式结算配置。App 名称与版本从宿主信息读取。

SDK 不要求额外 App ID 初始化。广告位须与媒体获授权的 App 和广告形式匹配。启动配置见 [`AppDelegate.m`](YSIFLYADLibSimple/AppDelegate.m)，首页入口见 [`ViewController.m`](YSIFLYADLibSimple/ViewController.m)。

## 隐私与网络设置

- 示例在 App 激活后申请 ATT，并在每次请求时检查授权、过滤全零 IDFA。拒绝 ATT 时继续以空 IDFA 请求；不要为了取得 IDFA 重复弹窗。
- 示例不包含生产 App 的隐私同意页面。接入自己的 App 时，应按用户授权和业务要求安排 SDK 使用时机；`ysifly_setPersonalizedEnabled:` 只记录状态，不会代替隐私流程或停止广告请求。
- [`Info.plist`](YSIFLYADLibSimple/Info.plist) 含 `NSUserTrackingUsageDescription` 和用于测试素材的 ATS 例外。生产 App 请使用准确的用途文案，并按实际网络需求收窄 ATS 配置。
- 示例开启日志便于查看回调。上线前按需关闭 `ysifly_setLogEnabled:`，反馈问题时隐藏设备标识、Token 和业务敏感数据。

## 体验开屏

首页只有“开屏广告”入口，对应 [`YSIFLYSplashViewController.m`](YSIFLYADLibSimple/biz/splash/YSIFLYSplashViewController.m)。

1. 选择“图片开屏”或“视频开屏”，点击 `Load`。每次加载都会清理旧对象并创建新实例。
2. 日志出现 `splashAdDidLoad` 表示响应已解析。继续等待 `splashAdDidReady`；广告有效后 `Show` 才可点击。
3. 点击 `Show`。示例使用 `YSIFLYSplashAdConfig`，展示倒计时与底部品牌区；视频初始静音，并显示静音按钮。
4. 查看展示、曝光、点击、跳转、跳过和关闭回调。关闭后可再次加载；已展示的对象不能作为下一次广告机会复用。
5. “检查状态”记录 `ysifly_isAdValid` 和公开竞价信息；`Destroy` 终止当前广告。退出页面会释放广告。

本例手动展示便于观察回调。实际启动页请由宿主协调隐私授权、广告请求与展示时机，并保留超时/失败后的主流程。SDK 不需要宿主再次 `present` 开屏控制器；将当前有效控制器传给 `ysifly_showAdFromRootViewController:config:` 即可。

图片与视频共用 `YSIFLYSplashAd`；是否返回视频以 `hasVideoTemplate` 和实际素材为准。示例底部品牌区由 `bottomLogoView` 创建，可参考其尺寸和布局方式换成自己的品牌内容。

## 如何确认接入成功

| 阶段 | 可观察结果 |
| --- | --- |
| 安装 | `pod install` 成功，workspace 构建和运行通过 |
| 首页 | 显示 `SDK Version: 6.4.0`，只有开屏入口 |
| 加载 | `splashAdDidLoad` 后出现 `splashAdDidReady`，Show 可点击 |
| 展示 | 图片/视频可见，收到 `splashAdDidShow`；满足可见条件后收到曝光回调 |
| 关闭 | 跳过或关闭后回到示例页面，能够发起下一次加载 |
| 失败处理 | 断网、超时或无填充时记录错误，Show 不会启用，页面可操作 |
| 真机交互 | 验证点击跳转与返回、前后台切换、视频声音及 ATT 拒绝/授权路径 |

构建成功只证明依赖可以消费和链接。示例广告位、模拟器或当前请求无填充时，不代表安装错误；需使用媒体获分配的广告位在真机继续联调。

## 常见问题

| 现象 | 检查方法 |
| --- | --- |
| 下载依赖失败 | 检查 `raw.githubusercontent.com`、本版 Release、代理和证书，按错误 URL 定位后重试 |
| 找不到 `YSIFLYADLibSplash` 头 | `YSIFLYADLibSplash` 是依赖/产品名，导入模块为 `YSIFLYADLib`；使用 workspace |
| 重复符号或资源 | 移除原多格式 YS 依赖及手工拷贝文件，只保留当前 SDK 和一份 `YSAdvSDK.bundle` |
| 真机签名失败 | 设置自己的 Team、Bundle Identifier 并确认设备可开发 |
| Show 不可点击 | 需收到 Ready 且实例有效；查看错误日志，不能仅凭 DidLoad 展示 |
| 广告无填充 | 核对广告位、App 信息、开屏类型、后台授权与网络；不要循环无间隔重试 |
| IDFA 为空 | 未授权或拒绝 ATT 时为空是预期行为；授权后新请求会重新读取 |
| 视频或图标异常 | 检查素材错误回调和 `YSAdvSDK.bundle` 是否被正确复制到 App |
| 展示失败或黑屏 | 确认当前控制器已位于有效 window、App 在前台；避免与其他模态展示冲突 |

反馈请使用 [Issues](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/issues)，附 SDK/iOS/Xcode 版本、设备类型、复现步骤、错误码和脱敏日志。版本变化见[更新记录](../CHANGELOG.md)。
