// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "mail-service",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0"),
        .package(url: "https://github.com/twof/VaporMailgunService.git", from: "1.5.0"),
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.3.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["JWT", "Vapor", "Mailgun", "ServiceExt"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
