// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Stocks",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.88.0"),
        .package(url: "https://github.com/vapor-community/HTMLKit", branch: "3.0.0-alpha.7")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "HTMLKit", package: "HTMLKit"),
            ]
        )
    ]
)
