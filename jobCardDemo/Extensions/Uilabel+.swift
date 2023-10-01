//
//  Uilabel+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
extension UILabel{
   
    convenience init(text:String, font:UIFont,textColor: UIColor){
        self.init(frame:.zero)
        self.font = font
        self.text = text
        self.textColor  = textColor
        
    }
    var  textCenter:UILabel {
       textAlignment = .center
        return self
    }
    var lineZero :UILabel {
        numberOfLines = 0
        return self
    }
    
    var centerZero:UILabel {
         textAlignment = .center
        numberOfLines = 0
        return self
    }
    
}

extension UILabel {
    func underLine(){
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: self.text ?? "", attributes: underlineAttribute)
        self.attributedText = underlineAttributedString
    }
}

