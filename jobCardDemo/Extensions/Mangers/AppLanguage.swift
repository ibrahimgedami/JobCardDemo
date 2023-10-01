//
//  AppMainLang.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

struct AppMainLang {
    
    private init() { }
    
    static var appMainLang: String {
        get {
            // Locale.current not changed after change lang
            // return Locale.current.languageCode ?? "en"
            let userdef = UserDefaults.standard
            let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
            let current = langArray.firstObject as! String
            let endIndex = current.index(current.startIndex, offsetBy: 2)
            let currentWithoutLocale = current[current.startIndex..<endIndex]
            return String(currentWithoutLocale)
        }
    }
    
    static func isRTLLanguage(language: String = appMainLang) -> Bool {
        return language.hasPrefix("ar") || language.hasPrefix("fa")
    }
    
    static var langTextAlignment: NSTextAlignment {
        get {
            if AppMainLang.isRTLLanguage() {
                return .right
            } else {
                return .left
            }
        }
    }
}

extension NSTextAlignment {
    static var langTextAlignment: NSTextAlignment {
        get {
            return AppMainLang.langTextAlignment
        }
    }
}
