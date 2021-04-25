import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:],
    "UIRequiresFullScreen": .boolean(true),
    "UIAppFonts": [
        "Wes.ttf",
        "Lumberjack.otf",
        "Matias.ttf"
    ]
]

// MARK: - Application Target

let domain = "name.domain.youreader"

let appTarget = Target(
    name: "App",
    platform: .iOS,
    product: .app,
    bundleId: "\(domain).app",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Projects/App/Sources/**/*.swift"],
    resources: ["Projects/App/Resources/**/*"],
    dependencies: [
        .target(name: "Core"),
        .target(name: "UIComponents"),
        .package(product: "DifferenceKit")
    ]
)

let appTests = Target(
    name: "AppTests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "\(domain).appTests",
    infoPlist: .default,
    sources: ["Projects/App/Tests/**"],
    dependencies: [
        .target(name: "App")
    ]
)

// MARK: - Core Target

let coreFrameworkTarget = Target(
    name: "Core",
    platform: .iOS,
    product: .framework,
    bundleId: "\(domain).core",
    infoPlist: .default,
    sources: ["Projects/Core/Sources/**/*.swift"],
    resources: ["Projects/Core/Resources/**/*"]
)

// MARK: - CoreUI Target

let uiComponentsFrameworkTarget = Target(
    name: "UIComponents",
    platform: .iOS,
    product: .framework,
    bundleId: "\(domain).appUI",
    infoPlist: .default,
    sources: ["Projects/UIComponents/Sources/**/*.swift"],
    resources: ["Projects/UIComponents/Resources/**/*"],
    dependencies: [
        .package(product: "SnapKit"),
        .target(name: "Core")
    ]
)

// MARK: - Project

let project = Project(
    name: "YouReader",
    organizationName: "YouReader Inc",
    packages: [
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            Package.Requirement.upToNextMajor(from: "5.0.1")
        ),
        .package(
            url: "https://github.com/ra1028/DifferenceKit.git",
            Package.Requirement.upToNextMajor(from: "1.1.5")
        )
    ],
    settings: nil,
    targets: [
        appTarget,
        appTests,
        coreFrameworkTarget,
        uiComponentsFrameworkTarget
    ]
)
