//
//  UIImage+.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIImage {
    var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    var original: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}

extension UIImage{
    func toData()->Data?{
        let data = self.jpegData(compressionQuality: 0.5)
        return data
    }
}
extension UIImage {
    static let homeTab = UIImage(named: "home_a")!
    static let notifyTab = UIImage(named: "notification_in")!
    static let myOrderTab = UIImage(named: "orders_in")!
    static let profileTab = UIImage(named: "profile_in")!
    
    static let homeService1 = UIImage(named: "ride_flip")!
    static let homeService2 = UIImage(named: "delivery_flip")!
    static let homeService3 = UIImage(named: "room_flip")!
    static let homeService4 = UIImage(named: "bicycle_flip")!

    static let mapIcon = UIImage(named: "location_map")!
    
    
    static let check = UIImage(named: "Group 18706")!
    static let unCheck = UIImage(named: "tick-mark-3")!
    static let completed = UIImage(named: "Ellipse 34")!
    
    static let transactionIn = UIImage(named: "greenArrow")!
    static let transactionOut = UIImage(named: "redArrow")!
}
