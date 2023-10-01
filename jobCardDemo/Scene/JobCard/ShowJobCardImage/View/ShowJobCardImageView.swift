//
//  JobCardImageView.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/24/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct ShowJobCardImageView: View {
    
    @State private var imageSize: CGSize = .zero
    var viewModel: ShowJobCardImageViewModelProtocol?
    
    var body: some View {
        GeometryReader { proxy in
            viewModel?.getSelectedImage
                .onTapGesture(perform: {
                    DispatchQueue.main.async {
                        self.imageSize = CGSize(width: proxy.size.width, height: proxy.size.height)
                    }
                })
//                .scaledToFit()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipShape(Rectangle())
                .modifier(ImageModifier(contentSize: imageSize))
        }
    }
    
}

