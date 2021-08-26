// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "RSConfettiView",
	platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "RSConfettiView",          
            targets: ["RSConfettiView"]),
    ],
    targets: [
        .target(
            name: "RSConfettiView",
			path: "Sources"
		)
    ],
	swiftLanguageVersions: [.v5]
)
