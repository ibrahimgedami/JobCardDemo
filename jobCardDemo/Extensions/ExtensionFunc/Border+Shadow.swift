//
//  Border+Shadow.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIView {
    func setRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    func setShadow(radius: CGFloat){
        self.layer.shadowColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5215053937)
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 13
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = radius
    }
}
