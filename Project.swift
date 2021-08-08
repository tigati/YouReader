import ProjectDescription

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleDevelopmentRegion": "ua",
    "CFBundleDisplayName": "ТыЧиталка",
    "UILaunchStoryboardName": "LaunchScreen",
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UIRequiresFullScreen": .boolean(true),
    "UIAppFonts": [
        "Wes.ttf",
        "Lumberjack.otf",
        "Matias.ttf"
    ]
]

let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "11.0", devices: [.iphone, .ipad])

// MARK: - Application Target

let domain = "games.lemur.youreader"

let appTarget = Target(
    name: "App",
    platform: .iOS,
    product: .app,
    bundleId: "\(domain)",
    deploymentTarget: deploymentTarget,
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
    bundleId: "\(domain).tests",
    deploymentTarget: deploymentTarget,
    infoPlist: .default,
    sources: ["Projects/App/Tests/**"],
    dependencies: [
        .target(name: "App"),
        .package(product: "SnapshotTesting")
    ]
)

// MARK: - Core Target

let coreFrameworkTarget = Target(
    name: "Core",
    platform: .iOS,
    product: .framework,
    bundleId: "\(domain).core",
    deploymentTarget: deploymentTarget,
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
    deploymentTarget: deploymentTarget,
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
    organizationName: "Lemur Games",
    packages: [
        .package(
            url: "https://github.com/SnapKit/SnapKit.git",
            Package.Requirement.upToNextMajor(from: "5.0.1")
        ),
        .package(
            url: "https://github.com/ra1028/DifferenceKit.git",
            Package.Requirement.upToNextMajor(from: "1.1.5")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            Package.Requirement.upToNextMajor(from: "1.8.1"))
    ],
    settings: nil,
    targets: [
        appTarget,
        appTests,
        coreFrameworkTarget,
        uiComponentsFrameworkTarget
    ]
)
