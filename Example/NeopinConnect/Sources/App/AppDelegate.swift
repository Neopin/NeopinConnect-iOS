//
//  AppDelegate.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/02.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - App Life Cycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavigationTabbarController = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = rootNavigationTabbarController
        window?.makeKeyAndVisible()

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        ConnectManager.shared.disconnect()
    }
}


