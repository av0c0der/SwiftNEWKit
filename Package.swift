// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Created by Ming on 11/6/2022.
//

import PackageDescription

let package = Package(
    name: "SwiftNEW",
    platforms: [
        .iOS(.v15),
        .macOS(.v14),
        .visionOS(.v1),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftNEW",
            targets: ["SwiftNEW"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "SwiftNEW",
            dependencies: [
                
            ]
        )
    ]
)
