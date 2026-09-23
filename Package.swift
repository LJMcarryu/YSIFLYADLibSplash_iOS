// swift-tools-version:5.9

// 萤石图片/视频仅开屏发行包；同 App 不得与原 YS 包同时链接。
import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.4.0 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            // 6.4.0 正式 prepare 产物的真实 SwiftPM checksum。
            url: "https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/download/6.4.0/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "e20a4898a2c2f03e321fc6cec948e2bd87260ac19d6f6182117e3f07410b977d"
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
