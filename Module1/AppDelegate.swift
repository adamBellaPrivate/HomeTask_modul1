//
//  AppDelegate.swift
//  Module1
//
//  Created by Adam Bella on 2022. 02. 27..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let appCoordinator = ApplicationCoordinator(rootViewController: UINavigationController())

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setDefaultWindow()
        print("Test log")
        print("Test log")
        return true
    }
}

private extension AppDelegate {
    func setDefaultWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
    }
}
