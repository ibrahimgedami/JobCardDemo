//
//  AppConfiguration.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 9/26/23.
//

import Foundation
import SwiftUI

protocol ConfigurationProtocol {
    associatedtype RootView: View
    var view: RootView {get}
}

@available(iOS 16.0, *)
enum AppConfiguration: ConfigurationProtocol {
    
    case jobCardDetail(model: JobCardDetailsModel)
    case showJobCardImage(image: RemoteImageView)
    
    var view: some View {
        switch self {
        case .jobCardDetail(let model):
            var view = JobCardDetailsView()
            let viewModel = JobCardDetailViewModel(model: model)
            view.viewModel = viewModel
            return AnyView(view)

        case .showJobCardImage(let image):
            var view = ShowJobCardImageView()
            let viewModel = ShowJobCardImageViewModel(selectedImage: image)
            view.viewModel = viewModel
            return AnyView(view)
        }
    }
}
