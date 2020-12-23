// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "LAMP",
    platforms: [
        .iOS(.v12),
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
            path: "Sources/Sensors"
        ),
    ]
)
