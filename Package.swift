// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "bkrideapi",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "bkrideapi",
            targets: [
                "bkrideapi"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/XbikeJavierBC/bksdkcore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/XbikeJavierBC/bklocalrepositorycore.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/YAtechnologies/GoogleMaps-SP.git",
                .upToNextMinor(from: "6.0.0")
        ),
    ],
    targets: [
        .target(
            name: "bkrideapi",
            dependencies: [
                "bksdkcore",
                "bklocalrepositorycore",
                .product(
                    name: "GoogleMaps",
                    package: "GoogleMaps-SP"
                ),
                .product(
                    name: "GooglePlaces",
                    package: "GoogleMaps-SP"
                ),
            ],
            resources: [
                .process("resources/localizable")
            ]
        ),
        .testTarget(
            name: "bkrideapiTests",
            dependencies: [
                "bkrideapi"
            ]
        ),
    ]
)
