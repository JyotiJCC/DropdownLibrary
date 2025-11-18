// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DropdownLibrary",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "DropdownLibrary",
            targets: ["DropdownLibrary"]),
    ],
    targets: [
        .target(
            name: "DropdownLibrary",
            dependencies: [],
            resources: [
                            .process("Resources")
            ]
        ),

        .testTarget(
            name: "DropdownLibraryTests",
            dependencies: ["DropdownLibrary"]
        ),
    ]
)
