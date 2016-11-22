import PackageDescription

let package = Package(
  name: "SwiftRL",
  targets: [],
  dependencies: [
    .Package(url: "https://github.com/PeteRichardson/Cncurses.git", majorVersion: 1)
  ]
  
)