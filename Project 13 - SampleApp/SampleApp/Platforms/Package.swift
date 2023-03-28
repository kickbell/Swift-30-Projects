// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Platforms",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "Network",
      targets: ["Network"]
    ),
    .library(
      name: "NetworkImp",
      targets: ["NetworkImp"]
    ),
    .library(
      name: "CommonUI",
      targets: ["CommonUI"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Network",
      dependencies: [
        
      ]
    ),
    .target(
      name: "NetworkImp",
      dependencies: [
        "Network"
      ]
    ),
    .target(
      name: "CommonUI",
      dependencies: [
      ]
    ),
  ]
)
