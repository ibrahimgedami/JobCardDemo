//
//  ShowJobCardImageViewModel.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 10/1/23.
//

import Foundation

protocol ShowJobCardImageViewModelProtocol: AnyObject {
    var getSelectedImage: RemoteImageView { get }
}

class ShowJobCardImageViewModel {
    
    let selectedImage: RemoteImageView
    
    init(selectedImage: RemoteImageView) {
        self.selectedImage = selectedImage
    }
    
}

extension ShowJobCardImageViewModel: ShowJobCardImageViewModelProtocol {
    
    var getSelectedImage: RemoteImageView {
        return selectedImage
    }
    
}
