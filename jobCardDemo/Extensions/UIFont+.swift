//
//  UIFont+.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func cairoExtraBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProMedium", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoLight(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProLight", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansPro-Bold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoSemiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    
    static func cairoRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansPro-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func cairoBlack(of size: CGFloat) -> UIFont {
        return UIFont(name: "NeoSansProBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
   
   ///**ProximaSoft Font

    static func proximaExtraBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func proximaLight(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-Light", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func proximaBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-Bold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func proximaSemiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-SemiBold", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    
    static func proximaRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    static func proximaBlack(of size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaSoft-Black", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
    
    var bold: UIFont {
        return UIFont(descriptor: fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }
}

