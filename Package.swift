// swift-tools-version:5.9

// 萤石图片/视频仅开屏发行包；同 App 不得与原 YS 包同时链接。
import PackageDescription

let package = Package(
    name: "YSIFLYADLibSplash",
    // 6.3.1 目标二进制继续按 iOS 11 构建；资源由资源 target 同步投递。
    platforms: [
        .iOS("11.0"),
    ],
    products: [
        .library(name: "YSIFLYADLibSplash", targets: ["YSIFLYADLib", "YSIFLYADLibResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "YSIFLYADLib",
            // 正式 prepare 完成后回填签名 zip checksum。
            url: "https://github.com/LJMcarryu/YSIFLYADLibSplash_iOS/releases/download/6.3.1/YSIFLYADLib-SplashOnly.xcframework.zip",
            checksum: "__YSIFLYADLIB_6_3_1_SWIFTPM_CHECKSUM_PENDING__"
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
