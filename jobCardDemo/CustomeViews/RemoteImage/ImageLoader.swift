//
//  ImageLoader.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/23/23.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var imageCache: [URL: UIImage] = [:]

    func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageCache[url] = image
                }
            }
        }.resume()
    }
}
