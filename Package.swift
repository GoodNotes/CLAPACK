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
      exclude: ["SRC/VARIANTS", "SRC/CMakeLists.txt", "SRC/Makefile"],
      sources: ["SRC"],
      publicHeadersPath: "INCLUDE"
    )
  ]
)
