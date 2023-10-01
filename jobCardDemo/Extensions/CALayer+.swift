//
//  CALayer+.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
extension CALayer {
    func applySketchShadow(color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), alpha: Float = 0.24, x: CGFloat = 0, y: CGFloat = 3, blur: CGFloat = 6, spread: CGFloat = 0, viewRadius: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        masksToBounds = false
    }
}
