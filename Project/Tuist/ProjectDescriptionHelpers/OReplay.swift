import ProjectDescription

public struct OReplay {
    public static let name = "OReplay"
    private static let bundleId = "com.ruralnerd.\(name)"
    private static let extraValues: [String: Plist.Value] = [
        "CFBundleShortVersionString": "0.1",
        "CFBundleVersion": "1",
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
        ]
    
    public static func targets() -> [Target] {
        [
            .target(name: name,
                    destinations: [.iPad, .iPhone],
                    product: .app,
                    productName: name,
                    bundleId: bundleId,
                    deploymentTargets: DeploymentTargets.multiplatform(iOS: "17.0"),
                    infoPlist: .extendingDefault(with: extraValues),
                    sources: ["\(name)/Sources/**"],
                    resources: ["\(name)/Resources/**)"],
                    dependencies: [],
                    settings: settings()
                   ),
            .target(name: "\(name)Test",
                    destinations: [.iPad, .iPhone],
                    product: .unitTests,
                    productName: "\(name)Test",
                    bundleId: "\(bundleId)Tests",
                    deploymentTargets: DeploymentTargets.multiplatform(iOS: "17.0"),
                    infoPlist: .default,
                    sources: ["\(name)/Tests/**"],
                    resources: [],
                    dependencies: [.target(name: name)],
                    settings: settings()
                   )
        ]
    }
    
    private static func settings() -> Settings {
        var baseSettings: SettingsDictionary = [
            "DEAD_CODE_STRIPPING": true,
            "SWIFT_STRICT_CONCURRENCY": .string("complete"),
            "SWIFT_VERSION": .string("6.0"),
            ]
        var releaseSettings = SettingsDictionary().automaticCodeSigning(devTeam: "H6736Y4CV2")
        releaseSettings["SWIFT_COMPILATION_MODE"] = "wholemodule"
        releaseSettings["SWIFT_VERSION"] = .string("6.0")

        var debugSettings = SettingsDictionary().automaticCodeSigning(devTeam: "H6736Y4CV2")
        debugSettings["SWIFT_COMPILATION_MODE"] = "singlefile"
        debugSettings["SWIFT_VERSION"] = .string("6.0")
        
        return .settings(base: baseSettings, configurations: [
            .debug(name: "debug", settings: debugSettings),
            .release(name: "release", settings: releaseSettings)
        ])
    }
}

