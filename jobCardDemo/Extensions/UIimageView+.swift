//
//  UIimageView+.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(with url: String?, cop: ((_ image: UIImage?) -> Void)? = nil) {
        let placeHolder = #imageLiteral(resourceName: "gold corner")
        image = placeHolder
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .MainYellow
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.image = placeHolder
                cop?(nil)
            } else {
                self?.image = image
                cop?(image)
            }
        }
    }
}

extension UIButton {
    func load(with url: String?, cop: ((_ image: UIImage?) -> Void)? = nil) {
        let placeHolder = #imageLiteral(resourceName: "placeHolder")
        setBackgroundImage(placeHolder, for: .normal)
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicatorView = UIActivityIndicatorView(style: .gray)
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .MainYellow
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, for: .normal, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            activityIndicatorView.removeFromSuperview()
            if image == nil {
                self?.setBackgroundImage(placeHolder, for: .normal)
                cop?(nil)
            } else {
                self?.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
                cop?(image)
            }
        }
    }
}

class FlipImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        let language = L102Language.getCurrentLanguage()
        print(language)
        if language == "ar" {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }else{
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

enum RoundType {
    case top
    case none
    case bottom
    case both
}

extension UIView {

    func round(with type: RoundType, radius: CGFloat = 3.0) {
        var corners: UIRectCorner

        switch type {
        case .top:
            corners = [.topLeft, .topRight]
        case .none:
            corners = []
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .both:
            corners = [.allCorners]
        }

        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

}

