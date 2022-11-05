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
        .library(name: "AppUI", targets: ["AppUI"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "DataSource", targets: ["DataSource"]),
        .library(name: "SearchFeature", targets: ["SearchFeature"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", exact: "6.6.1"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "0.40.2"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", exact: "4.2.2"),
    ],
    targets: [
        .target(
            name: "AppKit",
            dependencies: [
                "AppFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ]),
        .target(
            name: "AppFeature",
            dependencies: [
                "SearchFeature",
                "DataSource",
            ]),
        .target(
            name: "AppUI",
            resources: [
                .process("Resources"),
            ],
            plugins: [
//                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"),
            ]
        ),
        .target(name: "Core"),
        .target(name: "DataSource",
                dependencies: [
                    "Core",
                ]),
        .target(
            name: "SearchFeature",
            dependencies: [
                "AppUI",
                "DataSource",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
    ]
)
