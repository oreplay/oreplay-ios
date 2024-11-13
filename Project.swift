import ProjectDescription

let project = Project(
    name: "project",
    targets: [
        .target(
            name: "project",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.project",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["project/Sources/**"],
            resources: ["project/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "projectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.projectTests",
            infoPlist: .default,
            sources: ["project/Tests/**"],
            resources: [],
            dependencies: [.target(name: "project")]
        ),
    ]
)
