// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubSearch_TCA",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "AppKit", targets: ["AppKit"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppKit",
            dependencies: [
                "AppFeature",
            ]),
        .target(
            name: "AppFeature"
        ),
    ]
)
