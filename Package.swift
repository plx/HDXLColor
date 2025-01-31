// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HDXLColor",
  platforms: [
    SupportedPlatform.iOS(.v13),
    SupportedPlatform.macOS(.v10_15),
    SupportedPlatform.tvOS(.v13),
    SupportedPlatform.watchOS(.v6)
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "HDXLColor",
      targets: ["HDXLColor"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/plx/HDXLCommonUtilities",
      from: "0.0.40"
    ),
    .package(
      url: "https://github.com/plx/HDXLSIMDSupport",
      from: "0.0.15"
    ),
    .package(
      url: "https://github.com/plx/HDXLTestingUtilities",
      from: "0.0.6"
    ),
    .package(
      url: "https://github.com/plx/HDXLAlgebraicUtilities",
      from: "0.0.4"
    ),
    .package(
      url: "https://github.com/plx/HDXLInterpolation",
      from: "0.0.0"
    )
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "HDXLColor",
      dependencies: [
        "HDXLCommonUtilities",
        "HDXLSIMDSupport",
        "HDXLInterpolation",
        "HDXLAlgebraicUtilities"
      ]
    ),
    .testTarget(
      name: "HDXLColorTests",
      dependencies: [
        "HDXLColor",
        "HDXLTestingUtilities"
      ]
    )
  ]
)

