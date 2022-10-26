// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "YCoreUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "YCoreUI",
            targets: ["YCoreUI"]
        )
    ],
    targets: [
        .target(
            name: "YCoreUI",
            dependencies: []
        ),
        .testTarget(
            name: "YCoreUITests",
            dependencies: ["YCoreUI"],
            resources: [.process("Assets")]
        )
    ]
)
