//
//  UserData.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//


import UIKit

class AppWindowManger {
    
    private init() { }
    
    static func restartAppAndRemoveUserDefaults() {
        let cacheService = CacheService()
        cacheService.setUserData(nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
//            AppDelegate.shared.window?.rootViewController = AuthConfiguration.authIntro.viewController.toNavigation
            UIView.transition(with: keyWindow, duration: 1.0, options: .curveEaseIn, animations: nil, completion: nil)
        }
    }
    
    static func authUser() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
//            keyWindow.rootViewController = TabBarController()
            UIView.transition(with: keyWindow, duration: 0.5, options: .transitionCurlUp, animations: nil, completion: nil)
        }
    }
    
    static func makeTransition(to vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }!
            keyWindow.rootViewController = vc
            UIView.transition(with: keyWindow, duration: 0.5, options: .curveEaseIn, animations: nil, completion: nil)
        }
    }
}

