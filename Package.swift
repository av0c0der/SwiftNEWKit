// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChangelogKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .visionOS(.v1),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "ChangelogKit",
            targets: ["ChangelogKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ChangelogKit",
            dependencies: []
        )
    ]
)
