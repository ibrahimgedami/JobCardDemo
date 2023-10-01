//
//  Int+.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var string: String {
        return "\(self)"
    }
}

extension Double {
    var string: String {
        return "\(self)"
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
