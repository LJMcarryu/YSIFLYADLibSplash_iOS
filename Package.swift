// swift-tools-version:5.9

// YS 图片与视频仅开屏 SDK；同一 App 不得与 YSIFLYADLib 同时链接。
// 在宿主 App target 的 Other Linker Flags 中添加 -ObjC。

import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.5.1 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            url: "https://download-adsdk.voiceads.cn/ios_sdk/6.5.1/ys-splash/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "a77baa86b76247ac7b180faa1e1bcca5d7dd539c05029330438b265ef0e33ae0"
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
