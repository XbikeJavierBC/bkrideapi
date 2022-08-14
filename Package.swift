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
        )
    ],
    targets: [
        .target(
            name: "bkrideapi",
            dependencies: [
                "bksdkcore"
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
