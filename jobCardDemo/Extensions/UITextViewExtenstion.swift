//
//  UITextViewExtenstion.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            label.textColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8039215686, alpha: 1)
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholderString: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            placeholderLabel.textAlignment = .natural
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            placeholderLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: textContainer.lineFragmentPadding).isActive = true
            placeholderLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: textContainer.lineFragmentPadding).isActive = true
            placeholderLabel.sizeToFit()
            textStorage.delegate = self
        }
    }

}

extension UITextView: NSTextStorageDelegate {

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

}

