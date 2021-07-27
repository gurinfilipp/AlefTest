//
//  AppDelegate.swift
//  AlefTest
//
//  Created by Филипп Гурин on 27.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainVC = MainViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        return true
    }


}

