//
//  CGFloat+.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func getHeigth(count: Int, itemHeight: Int, blus: CGFloat = 0, itemInRow: Int) -> CGFloat {
        var count = count
        let doubleCount: Double = Double(Double(count) / Double(itemInRow))
        count = count / itemInRow
        if doubleCount > Double(count) {
            count += 1
        }
        let heigh = (CGFloat(count * itemHeight) + blus)
        return heigh
    }
}
