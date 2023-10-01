//
//  ViewController + Picker.swift
//  My Meal Client
//
//  Created by Ibrahim Mo Gedami on 5/25/22.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit
//import YPImagePicker
import AVFoundation

extension UIViewController {
//    func initVideo(screens: [YPPickerScreen] = [.library, .video, .photo], libraryType: YPlibraryMediaType = .photoAndVideo,completion: @escaping (Data?, Bool, MessageMediaType?) -> Void) {
//        var config = YPImagePickerConfiguration()
//        config.screens = screens
//        config.library.mediaType = libraryType
//        config.video.fileType = .mp4
//        config.video.compression = AVAssetExportPreset640x480
//        config.maxCameraZoomFactor = 4
//        config.video.libraryTimeLimit = 30
//        config.video.recordingTimeLimit = 30
//
//        let picker = YPImagePicker(configuration: config)
//        present(picker, animated: false, completion: nil)
//
//        picker.didFinishPicking { [unowned picker] items, cancel in
//            if cancel {
//                completion(nil, true, nil)
//                picker.dismiss(animated: true, completion: nil)
//            }else if let video = items.singleVideo {
//                print(video.fromCamera)
//                print(video.thumbnail)
//                guard let data = try? Data(contentsOf: video.url) else {
//                    completion(nil, false, nil)
//                    return
//                }
//                completion(data, false, .video)
//
//                picker.dismiss(animated: true, completion: nil)
//            }else if let image = items.singlePhoto {
//                guard let data = image.image.toData() else {
//                    completion(nil, false, nil)
//                    return
//                }
//                completion(data, false, .image)
//
//                picker.dismiss(animated: true, completion: nil)
//            }
//        }
//    }

}

