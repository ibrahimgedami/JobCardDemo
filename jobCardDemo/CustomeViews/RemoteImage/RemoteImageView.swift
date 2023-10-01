//
//  RemoteImageView.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/23/23.
//

import SwiftUI

struct RemoteImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL

    init(imageURL: URL, imageLoader: ImageLoader) {
        self.imageURL = imageURL
        self.imageLoader = imageLoader
    }

    var body: some View {
        if let image = imageLoader.imageCache[imageURL] {
            Image(uiImage: image)
                .resizable()
//                .frame(height: UIScreen.main.bounds.width / 2) // Adjust the size as needed
                .padding()
        } else {
            Image(systemName: "placeholder") // Placeholder image
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(height: 200) // Adjust the size as needed
                .onAppear {
                    imageLoader.loadImage(url: imageURL)
                }
        }
    }
}
