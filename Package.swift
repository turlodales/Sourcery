// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Sourcery",
    platforms: [
       .macOS(.v10_11),
    ],
    products: [
        .executable(name: "sourcery", targets: ["Sourcery"]),
        .library(name: "SourceryRuntime", targets: ["SourceryRuntime"]),
        .library(name: "SourceryJS", targets: ["SourceryJS"]),
        .library(name: "SourcerySwift", targets: ["SourcerySwift"]),
        .library(name: "SourceryFramework", targets: ["SourceryFramework"]),
    ],
    dependencies: [
        .package(name: "Commander", url: "https://github.com/kylef/Commander.git", .exact("0.9.1")),
        // PathKit needs to be exact to avoid a SwiftPM bug where dependency resolution takes a very long time.
        .package(name: "PathKit", url: "https://github.com/kylef/PathKit.git", .exact("1.0.0")),
        .package(name: "SourceKitten", url: "https://github.com/jpsim/SourceKitten.git", .exact("0.30.1")),
        .package(name: "StencilSwiftKit", url: "https://github.com/SwiftGen/StencilSwiftKit.git", .exact("2.8.0")),
        .package(name: "XcodeProj", url: "https://github.com/tuist/xcodeproj", .exact("7.18.0")),
        .package(name: "SwiftSyntax",
                 url: "https://github.com/apple/swift-syntax.git",
                 .exact("0.50300.0"))
    ],
    targets: [
        .target(name: "Sourcery", dependencies: [
            "SourceryFramework",
            "SourceryRuntime",
            "SourceryJS",
            "SourcerySwift",
            "Commander",
            "PathKit",
            .product(name: "SourceKittenFramework", package: "SourceKitten"),
            "StencilSwiftKit",
            "SwiftSyntax",
            "XcodeProj",
            "TryCatch",
        ]),
        .target(name: "SourceryRuntime"),
        .target(name: "SourceryUtils", dependencies: [
          "PathKit"
        ]),
        .target(name: "SourceryFramework", dependencies: [
          "PathKit",
          .product(name: "SourceKittenFramework", package: "SourceKitten"),
          "SwiftSyntax",
          "SourceryUtils",
          "SourceryRuntime"
        ]),
        .target(name: "SourceryJS", dependencies: [
          "PathKit"
        ]),
        .target(name: "SourcerySwift", dependencies: [
          "PathKit",
          "SourceryRuntime",
          "SourceryUtils"
        ]),
        .target(name: "TryCatch", path: "TryCatch"),
    ]
)
