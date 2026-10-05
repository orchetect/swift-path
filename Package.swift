// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-path",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .visionOS(.v1)],
    products: [
        .library(
            name: "SwiftPath",
            targets: ["SwiftPath"]
        )
    ],
    traits: [
        .default(enabledTraits: []),
        .trait(name: "osc")
    ],
    dependencies: [
        .package(url: "https://github.com/orchetect/swift-value-formatting", from: "0.1.0"),

        // opt-in trait packages
        .package(url: "https://github.com/orchetect/swift-osc-core", from: "1.4.1")
    ],
    targets: [
        .target(
            name: "SwiftPath",
            dependencies: [
                .product(name: "SwiftValueFormatting", package: "swift-value-formatting"),
                .product(name: "SwiftOSCCore", package: "swift-osc-core", condition: .when(traits: ["osc"]))
            ]
        ),
        .testTarget(
            name: "SwiftPathTests",
            dependencies: ["SwiftPath"]
        ),
        .testTarget(
            name: "SwiftPathURLTests",
            dependencies: ["SwiftPath"]
        )
    ],
    swiftLanguageModes: [.v6]
)
