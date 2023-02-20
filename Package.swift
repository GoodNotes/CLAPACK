// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "CLAPACK",
  products: [
    .library(name: "CLAPACK", targets: ["CLAPACK"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "CLAPACK",
      path: ".",
      exclude: [],
      sources: ["SRC", "F2CLIBS", "BLAS/SRC", "INSTALL"],
      publicHeadersPath: "INCLUDE",
      cSettings: [
        .headerSearchPath("./F2CLIBS/libf2c/"),
        .unsafeFlags(["-DINTEGER_STAR_8"]),
      ]
    ),
    .testTarget(
      name: "CLAPACKTests",
      dependencies: ["CLAPACK"],
      path: "BUILD_TESTS"
    ),
  ]
)
