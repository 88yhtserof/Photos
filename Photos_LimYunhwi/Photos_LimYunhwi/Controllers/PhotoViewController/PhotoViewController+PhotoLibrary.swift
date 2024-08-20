//
//  PhotoViewController+PhotoLibrary.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/20/24.
//

import UIKit
import Photos

extension PhotoViewController {
    
    @MainActor
    func progressHandler(progress: Double, error: (any Error)?, stop: UnsafeMutablePointer<ObjCBool>, info: [AnyHashable : Any]?) -> Void {
        Task {
            self.progressView.progress = Float(progress)
        }
    }
    
    func resultHandler(image: UIImage?, info: [AnyHashable : Any]?) -> Void {
        guard let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool else { return }
        
        if isDegraded && self.imageView.image == nil {
            self.imageView.image = image
        }
        if !isDegraded {
            self.imageView.image = image
            self.progressView.isHidden = true
        }
    }
}
