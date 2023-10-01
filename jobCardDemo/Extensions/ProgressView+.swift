//
//  ProgressView.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
extension UIViewController{
    func drawBgShape(shape:CAShapeLayer, view: UIView , label: UILabel) {
        shape.path = UIBezierPath(arcCenter: CGPoint(x: label.frame.midX , y: label.frame.midY), radius:
                                            33, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        shape.strokeColor = UIColor.lightGray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 2.5
        view.layer.addSublayer(shape)
    }
    func drawTimeLeftShape(shape:CAShapeLayer, view: UIView , label: UILabel) {
        shape.path = UIBezierPath(arcCenter: CGPoint(x: label.frame.midX , y: label.frame.midY), radius:
                                                33, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 2.5
        view.layer.addSublayer(shape)
    }
}
