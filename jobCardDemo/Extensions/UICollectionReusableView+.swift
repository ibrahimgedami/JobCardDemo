//
//  UICollectionReusableView+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 4/13/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

extension UICollectionReusableView{
    
    func viewTapped(viewTapped: UIView, action: Selector) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        viewTapped.addGestureRecognizer(tap)
    }
}
