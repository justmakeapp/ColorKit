// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ColorKit",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        .library(
            name: "ColorKit",
            targets: ["ColorKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ColorKit",
            dependencies: []
        ),
    ],
    swiftLanguageVersions: [.v6]
)
