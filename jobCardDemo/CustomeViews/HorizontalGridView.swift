//
//  HorizontalGridView.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/24/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct HorizontalGridView: View {
    
    @State var imageUrls: [String] = []
    
    var body: some View {
        RemoteImageListView(imageUrls: imageUrls)
    }
    
}

@available(iOS 16.0, *)
struct RemoteImageListView: View {
    
    //MARK: - New Code
    let imageUrls: [String]
    let imageLoader = ImageLoader()
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 2.0
    
    func gridSwitch(){
        gridLayout = Array(repeating: GridItem(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
            ForEach(imageUrls, id: \.self){ imageURL in
                if let imageUrl = URL(string: imageURL) {
                    let image = RemoteImageView(imageURL: imageUrl, imageLoader: imageLoader)
                    NavigationLink(destination: AppConfiguration.showJobCardImage(image: image).view) {
                        image
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.gray.opacity(0.9), lineWidth: 1.5))
                            .frame(height: UIScreen.main.bounds.width / 3)
                    }
                }
            }
        }//LazyVGrid
        .onAppear {
            gridSwitch()
        }
        .padding()
    }
}

