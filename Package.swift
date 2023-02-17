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
      exclude: [
        "SRC/VARIANTS",
        "SRC/CMakeLists.txt",
        "SRC/Makefile",
        "F2CLIBS/CMakeLists.txt",
        "F2CLIBS/libf2c/Makefile",
        "F2CLIBS/libf2c/README",
        "F2CLIBS/libf2c/Notice",
        "F2CLIBS/libf2c/CMakeLists.txt",
        "F2CLIBS/libf2c/comptry.bat",
        "F2CLIBS/libf2c/scomptry.bat",
        "F2CLIBS/libf2c/main.c",
        "F2CLIBS/libf2c/mkfile.plan9",
        "F2CLIBS/libf2c/math.hvc",
        "F2CLIBS/libf2c/libf2c.sy",
        "F2CLIBS/libf2c/libf2c.lbc",
        "F2CLIBS/libf2c/f2ch.add",
        "BLAS/TESTING",
        "BLAS/SRC/CMakeLists.txt",
        "BLAS/SRC/Makefile",
        "INSTALL/lawn81.pdf",
        "INSTALL/Makefile",
        "INSTALL/lawn81.tex",
        "INSTALL/psfig.tex",
      ],
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
