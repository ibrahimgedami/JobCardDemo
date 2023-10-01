//
//  CollectionViewLoadingReusableView.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = .MainYellow
        activityIndicator.isHidden = true
        view.backgroundColor = .clear
    }
}
