// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LAMP",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "LAMP",
            targets: ["LAMP"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LAMP",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
