// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Miji",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Miji",
            targets: ["Miji"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "Miji",
            dependencies: []
        ),
        .testTarget(
            name: "MijiTests",
            dependencies: ["Miji"]
        ),
    ]
)
