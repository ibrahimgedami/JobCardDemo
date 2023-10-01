//
//  Color+Extension.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 9/30/23.
//

import SwiftUI

extension Color {
    
    // Create a Color from a hex color value, like "#RRGGBB" or "#RRGGBBAA"
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
    
}
