// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "LAMP",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "LAMP",
            targets: ["LAMP"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LAMP",
            dependencies: [],
            path: "LAMP/Classes"
        ),
    ]
)
