//
//  AppDelegate.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 9/26/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        if #available(iOS 16.0, *) {
            let nav = UINavigationController(rootViewController: MainViewController())
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        return true
    }
    
}

