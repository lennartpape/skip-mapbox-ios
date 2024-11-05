// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-mapbox",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        // Defines the library SkipMapbox, which is a dynamic library
        .library(name: "SkipMapbox", type: .dynamic, targets: ["SkipMapbox"]),
    ],
    dependencies: [
        // Dependencies from Skip and Mapbox
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
            // Add the path to the sources and specify all source files explicitly
            path: "Sources",
            sources: [
                "Annotation.swift",
                "CircleAnnotation.swift",
                "CommonMap.swift",
                "CoreLocationInterface.swift",
                "MapStyle.swift",
                "PointAnnotation.swift",
                "Puck2D.swift",
                "StyleColor.swift",
                "SwiftConversions.swift",
                "TurfInterface.swift",
                "ViewportAnimation.swift"
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "skipstone", package: "skip")
            ]
        ),
        .testTarget(
            name: "SkipMapboxTests",
            dependencies: [
                "SkipMapbox",
                .product(name: "SkipTest", package: "skip"),
                .product(name: "SkipUI", package: "skip-ui"),
                .product(name: "MapboxMaps", package: "mapbox-maps-ios", condition: .when(platforms: [.iOS]))
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "skipstone", package: "skip")
            ]
        ),
    ]
)
