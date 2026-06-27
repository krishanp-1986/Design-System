// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
        .executable(
            name: "DesignSystemDemo",
            targets: ["DesignSystemDemo"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.17.0"
        ),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            resources: [
                .process("Resources"),
            ]
        ),
        .executableTarget(
            name: "DesignSystemDemo",
            dependencies: ["DesignSystem"],
            path: "Examples/DesignSystemDemo"
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]
        ),
        .testTarget(
            name: "DesignSystemSnapshotTests",
            dependencies: [
                "DesignSystem",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
