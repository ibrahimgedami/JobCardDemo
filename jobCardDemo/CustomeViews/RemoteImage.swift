//
//  RemoteImage.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/24/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct RemoteImage: View {
    
    let urlString: String
    var body: some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    // Handle error
                    Text("Error loading image")
                case .empty:
                    // Placeholder while loading
                    ProgressView()
                @unknown default:
                    Text("Unknown state")
                }
            }
        } else {
            Text("Invalid URL")
        }
    }
    
}

