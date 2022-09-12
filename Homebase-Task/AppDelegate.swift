//
//  AppDelegate.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 09/09/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: ShiftsBuilder.build())
        navigationController.view.frame = UIScreen.main.bounds
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }


}

