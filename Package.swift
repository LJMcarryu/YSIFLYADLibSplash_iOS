// swift-tools-version:5.9

// 萤石图片/视频仅开屏发行包；同 App 不得与原 YS 包同时链接。
import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.4.1 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            // 6.4.1 正式 prepare 产物的真实 SwiftPM checksum。
            url: "https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/download/6.4.2/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "a71b972d487b0392b5a6e735c4d372138ee329e48700be6ca7f45a1d47318e80"
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
