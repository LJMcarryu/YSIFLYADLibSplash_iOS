# 萤石仅开屏 iOS SDK

`YSIFLYADLibSplash` 提供图片、视频开屏广告，最低支持 iOS 11.0。当前正式版本为 [6.3.5](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5)，不包含 Banner、插屏、自渲染信息流或激励广告。

<!-- ifly-release-status: {"schemaVersion":1,"version":"6.3.5","releaseState":"FORMAL","distribution":"github-release","releaseUrl":"https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5"} -->

首次体验从[示例运行指南](YSIFLYADLibSimple/README.md)开始；接入自己的 App 按本文安装、配置请求并处理生命周期；升级时查阅[更新记录](CHANGELOG.md)。接口以所安装版本的 framework 公开头为准。

| 项目 | 说明 |
| --- | --- |
| CocoaPods / SwiftPM 产品 | `YSIFLYADLibSplash` |
| 导入模块 | `YSIFLYADLib` |
| 广告入口 | `YSIFLYSplashAd`，图片/视频共用 |
| 方法与回调 | `ysifly_` 前缀；初始化方法与属性不加此前缀 |
| 交付 | 静态 XCFramework，含设备与模拟器切片；资源包 `YSAdvSDK.bundle` |
| 系统与工具 | iOS 11.0+；SwiftPM 清单要求 Swift tools 5.9 |

本包与多格式 `YSIFLYADLib` 使用相同模块、类型及资源，**同一 App 只能选择一个 YS 包**。从多格式包迁移时先移除旧依赖、手工 framework 和重复资源。

## 安装

选择一种安装方式，固定版本 `6.3.5`。

### CocoaPods

在 App 的 `Podfile` 使用正式版本的 Podspec URL：

```ruby
source 'https://cdn.cocoapods.org/'
platform :ios, '11.0'

target 'YourApp' do
  use_frameworks!
  pod 'YSIFLYADLibSplash',
      :podspec => 'https://raw.githubusercontent.com/LJMcarryu/YSIFLYADLibSplash_iOS/6.3.5/YSIFLYADLibSplash.podspec'
end
```

```bash
pod install
open YourApp.xcworkspace
```

该版本通过上述 URL 安装，无需依赖 CocoaPods trunk 收录。CocoaPods 自动加入资源、`-ObjC` 和所需系统库。

### Swift Package Manager

在 Xcode 的 **Add Package Dependencies** 添加仓库：

```text
https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS.git
```

选择 **Exact Version** `6.3.5`，将产品 `YSIFLYADLibSplash` 加入 App target。在 App target 的 **Other Linker Flags** 保留 `$(inherited)` 并添加 `-ObjC`。SwiftPM 自动加入资源包。

### 手动集成

从 [Release 6.3.5](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/tag/6.3.5) 下载 `YSIFLYADLib-SplashOnly-6.3.5.zip`，解压后：

1. 将 `YSIFLYADLib.xcframework` 加入 App target，选择 **Do Not Embed**。
2. 将 `YSAdvSDK.bundle` 加入 **Copy Bundle Resources**，确认最终 App 中只有一份。
3. 在 App target 的 **Other Linker Flags** 添加 `$(inherited) -ObjC`。
4. 链接 `AdSupport.framework`，将 `AppTrackingTransparency.framework` 设为 **Optional**，兼容 iOS 11～13。

三种方式均使用 `#import <YSIFLYADLib/YSIFLYADLib.h>`，不能根据依赖名称改为导入 `YSIFLYADLibSplash`。

## 加载与展示

以下示例放入一个 `.m` 文件，在宿主的加载时机调用 `loadSplash`，并将广告位替换为平台分配值。完整的可运行页面与手动 Load/Show 操作见 [Simple](YSIFLYADLibSimple/README.md)。

```objc
#import <YSIFLYADLib/YSIFLYADLib.h>

@interface SplashExampleViewController : UIViewController <YSIFLYSplashAdDelegate>
@property (nonatomic, strong) YSIFLYSplashAd *splashAd;
@end

@implementation SplashExampleViewController

// 在宿主隐私流程完成、页面可展示时调用。
- (void)loadSplash {
    [self clearSplash];
    self.splashAd = [[YSIFLYSplashAd alloc] initWithAdUnitId:@"YOUR_SPLASH_AD_UNIT_ID"];
    self.splashAd.delegate = self;
    self.splashAd.currentViewController = self;
    YSIFLYAdRequestConfig *request = [[YSIFLYAdRequestConfig alloc] init];
    request.requestTimeout = @5;
    [self.splashAd ysifly_loadAdWithRequestConfig:request];
}

- (void)ysifly_splashAdDidReady:(YSIFLYSplashAd *)ad {
    if (ad != self.splashAd || ![ad ysifly_isAdValid] || !self.view.window) return;
    YSIFLYSplashAdConfig *config = [[YSIFLYSplashAdConfig alloc] init];
    config.traceDuration = 5;
    config.muteOnStart = YES;
    config.muteButtonHidden = NO;
    [ad ysifly_showAdFromRootViewController:self config:config];
}

- (void)ysifly_splashAd:(YSIFLYSplashAd *)ad didFailWithError:(YSIFLYAdError *)error {
    if (ad != self.splashAd) return;
    NSLog(@"Splash failed: %d %@", error.errorCode, error.errorDescription);
    [self clearSplash]; // 宿主在此继续主流程，避免失败后停在启动页。
}

- (void)ysifly_splashAdDidClose:(YSIFLYSplashAd *)ad {
    if (ad == self.splashAd) [self clearSplash];
}

- (void)ysifly_splashAdDidSkip:(YSIFLYSplashAd *)ad {
    if (ad == self.splashAd) [self clearSplash];
}

- (void)clearSplash {
    self.splashAd.delegate = nil;
    [self.splashAd ysifly_destroy];
    self.splashAd = nil;
}

- (void)dealloc {
    [self.splashAd ysifly_destroy];
}
@end
```
### 展示配置与回调

| 配置/回调 | 含义与接入动作 |
| --- | --- |
| `traceDuration` | 倒计时秒数，有效范围 3～5；默认 5，越界回退为 5 |
| `mediumBottomView` | 宿主品牌区，需由媒体设置视图高度；示例提供 Logo 区域 |
| `customWindow` | 可选展示窗口；默认使用传入控制器所属 window |
| `muteOnStart` / `muteButtonHidden` | 视频初始静音状态、静音按钮是否隐藏 |
| `ysifly_splashAdDidLoad:` | 响应解析成功，可读 `bidInfo` 和 `hasVideoTemplate`，尚不能据此展示 |
| `ysifly_splashAdDidReady:` | 主素材已就绪；检查广告有效性与宿主可展示状态 |
| `ysifly_splashAdDidShow:` / `ysifly_splashAdDidExpose:` | 已显示到 window / 已达到有效曝光，是两个事件 |
| `ysifly_splashAdDidSkip:` | 用户点击跳过，广告关闭 |
| `ysifly_splashAdDidClose:` | 倒计时结束并关闭；不要把视频完播或跳转等同于本回调 |
| `ysifly_splashAd:didJumpWithSuccess:` | 点击跳转结果；SDK 负责跳转及回退，媒体不要再次打开链接 |
| `ysifly_splashAdDidPlayFinish:` | 视频播放完成，广告仍可保留末帧与交互，不表示关闭 |
| `ysifly_splashAd:didFailWithError:` | 统一加载/展示失败出口，记录错误并继续宿主流程 |

回调在主线程触发。强持有广告对象，并在展示前核对回调中的对象是否仍是当前实例。展示时传入已加入 window 的控制器；SDK 将开屏覆盖到窗口，无需宿主另外 `present` 广告控制器。

`ysifly_isAdValid` 仅表示实例当前是否可展示，不代替 Ready 和宿主可见性判断。成功展示后需要新建实例发起下一次请求。取消请求、宿主永久结束广告流程或释放页面时调用 `ysifly_destroy`；销毁后该对象不可恢复。不要仅因为广告打开了落地页就销毁仍在使用的广告。

## 请求配置与竞价

普通请求可调用 `ysifly_loadAd`，或通过 `ysifly_loadAdWithRequestConfig:` 传入 `YSIFLYAdRequestConfig`。请求超时、App 信息、底价等请求字段与 `YSIFLYSplashAdConfig` 展示配置分开设置。

| 常用请求字段 | 说明 |
| --- | --- |
| `requestTimeout` | 请求超时，单位秒 |
| `appName` / `appVersion` | 宿主 App 名称和版本 |
| `idfa` | 仅在 ATT 允许时传入有效标识 |
| `settleType` / `bidFloor` | 结算方式与底价，按平台协议设置；底价单位为 CNY 元/千次展示 |
| `deepLinkDisabled` | 是否禁用 DeepLink；点击和落地页跳转仍由 SDK 处理 |

`ysifly_splashAdDidLoad:` 后可读 `ad.bidInfo.price`、`ad.bidInfo.dealId`。只有接入 Header Bidding 时才按平台协议调用 `ysifly_sendBidResultWithType:reason:`；不要把加载成功自动等同于竞胜。

已开通 S2S 时，先通过 `YSIFLYAdSDK` 的 `ysifly_getSdkTokenWithAdUnitId:error:` 获取请求 Token 交给媒体服务端；收到服务端竞价胜出的响应 Token 后，为新的 `YSIFLYSplashAd` 调用 `ysifly_loadAdWithServerBiddingToken:`。两种 Token 不能互换，响应 Token 不可重复消费，也不要对同一实例同时调用普通加载与 S2S 加载。S2S 成功后的 `bidInfo.price` 固定为 `0`，不能据此判断实际竞价价格。

## 资源、隐私与网络

`YSAdvSDK.bundle` 包含广告所需资源及 `PrivacyInfo.xcprivacy`。CocoaPods / SwiftPM 会自动复制，手动集成需自行加入 App；不要同时使用多种安装方式或重复拷贝。宿主须结合实际功能填写自己的隐私说明和 App Store Connect 隐私标签。

SDK 无需额外 App ID 初始化。可在请求前通过 `YSIFLYAdConfig` 设置日志与个性化状态：`ysifly_setLogEnabled:` 用于排错，`ysifly_setPersonalizedEnabled:` **仅记录选择，不改变数据处理、请求、填充、展示或点击行为**。宿主应按自身授权流程控制何时使用 SDK，不能将状态开关当作停止采集或停止广告的控制器。

iOS 14 及以上如需 IDFA，宿主必须配置准确的 `NSUserTrackingUsageDescription`，在合适时机通过 `ATTrackingManager` 申请授权；只有 `authorized` 时才读取或传入 IDFA。未授权时传入的 IDFA 会被丢弃，授权后须重新读取并设置。示例中的授权和过滤逻辑见 Simple 的 `AppDelegate`、`YSIFLYADUtil`。

SDK 允许 HTTP 素材、监测地址和落地页，实际访问仍受宿主 ATS 策略影响。Simple 的网络例外用于联调；生产 App 应按实际域名和网络需求配置，优先使用 HTTPS。

正式上线建议关闭 SDK 日志；临时打开日志用于错误诊断，不要记录或公开完整 Token、设备标识或未脱敏请求。

## 错误处理与常见问题

通过 `YSIFLYAdError.errorCode` 和 `errorDescription` 记录失败。业务根据错误决定继续主流程或有限次重试，重试时新建对象，不要无间隔循环请求。

| 错误/现象 | 含义与处理 |
| --- | --- |
| `70204` | 没有广告填充；核对广告位与投放配置，继续宿主流程 |
| `70400` / `71005` | 广告位无效 / 为空；使用平台分配的当前媒体开屏广告位 |
| `71003` / `71006` | 网络错误 / 请求超时；检查网络并按业务策略重试 |
| `71601` / `71603` | 对象已展示 / 尚未就绪；新广告使用新对象，展示前等待 Ready |
| `71602` / `71605` | 素材加载 / 视频播放失败；记录错误后继续主流程 |
| `71604` | 展示控制器不可用；确认控制器已加入有效 window |
| 找不到头或链接失败 | 使用 workspace；确认模块名、`-ObjC` 和依赖安装结果 |
| duplicate symbols / 重复资源 | 移除其他 YS 包及手工重复依赖，只保留一种安装方式 |
| 视频结束但没有关闭回调 | 完播与广告关闭不同；分别处理完播、倒计时关闭和跳过 |
| IDFA 为空 | 未授权或拒绝 ATT 时为空是预期行为；授权后重新读取再发起新请求 |
| 示例可启动但没有广告 | 构建成功不等于有填充；替换为获分配的广告位，在真机核对后台授权 |

反馈问题请使用 [Issues](https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/issues)，附 SDK/iOS/Xcode 版本、接入方式、设备类型、操作步骤、错误码及脱敏日志。运行和页面检查步骤见[示例运行指南](YSIFLYADLibSimple/README.md)。
