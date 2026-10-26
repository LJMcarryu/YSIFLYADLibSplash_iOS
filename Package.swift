// swift-tools-version:5.9

// 萤石图片/视频仅开屏发行包；同 App 不得与原 YS 包同时链接。
import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.4.4 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            // 6.4.4 正式 prepare 产物的真实 SwiftPM checksum。
            url: "https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/download/6.4.4/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "6232511780bf16dba6f9a3f36f3d13b7715525f1739c2a43c4f519f06a0b09c3"
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
