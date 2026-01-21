// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ColorKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .visionOS(.v2),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "ColorKit",
            targets: ["ColorKit"]
        ),
        .library(
            name: "ColorKitUI",
            targets: ["ColorKitUI"]
        ),
    ],
    targets: [
        .target(
            name: "ColorKit",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "ColorKitUI",
            dependencies: ["ColorKit"]
        ),
    ]
)
