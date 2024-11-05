// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "skip-mapbox-ios",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "SkipMapbox", type: .dynamic, targets: ["SkipMapbox"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.0.7"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0"),
        .package(url: "https://github.com/mapbox/mapbox-maps-ios.git", exact: "11.6.0")
    ],
    targets: [
        .target(
            name: "SkipMapbox",
            dependencies: [
                .product(name: "SkipFoundation", package: "skip-foundation"),
                .product(name: "SkipUI", package: "skip-ui"),
                .product(name: "MapboxMaps", package: "mapbox-maps-ios", condition: .when(platforms: [.iOS]))
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(
            name: "SkipMapboxTests",
            dependencies: [
                "SkipMapbox", .product(name: "SkipTest", package: "skip"),
                .product(name: "SkipUI", package: "skip-ui"),
                .product(name: "MapboxMaps", package: "mapbox-maps-ios", condition: .when(platforms: [.iOS]))
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
    ]
)
