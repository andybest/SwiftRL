import PackageDescription

let package = Package(
        name: "SwiftRL",
        targets: [],
        dependencies: [
                .Package(url: "https://github.com/andybest/CTermbox.git", Version(0, 0, 1))
        ]

)