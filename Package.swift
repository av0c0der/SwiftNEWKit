// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Changelog",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .visionOS(.v1),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "Changelog",
            targets: ["Changelog"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Changelog",
            dependencies: []
        )
    ]
)
