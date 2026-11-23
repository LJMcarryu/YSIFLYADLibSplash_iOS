// swift-tools-version:5.9

// YS 图片与视频仅开屏 SDK；同一 App 不得与 YSIFLYADLib 同时链接。
// 在宿主 App target 的 Other Linker Flags 中添加 -ObjC。

import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.5.3 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            url: "https://download-adsdk.voiceads.cn/ios_sdk/6.5.3/ys-splash/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "a2fbe550ac1de7dd933f7e8c2bbcef350fdaa8a76a3859e3f7d1fdcd418ac6a8"
        ),
        .target(
            name: "YSIFLYADLibResources",
            path: "spm/YSIFLYADLibResources",
            resources: [
                .copy("YSAdvSDK.bundle"),
            ]
        ),
    ]
)
