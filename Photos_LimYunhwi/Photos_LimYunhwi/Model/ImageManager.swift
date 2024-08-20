//
//  ImageManager.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import UIKit
import Photos

struct ImageManager: ImageManagerProtocol {
    private var imageManager = PHImageManager()
    
    public func requestImage(with asset: PHAsset, mode deliveryMode: PHImageRequestOptionsDeliveryMode, size targetSize: CGSize, progressHandler: PHAssetImageProgressHandler? = nil, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
        
        let options = PHImageRequestOptions()
        options.deliveryMode = deliveryMode
        options.isNetworkAccessAllowed = true
        
        if let handler = progressHandler {
            options.progressHandler = handler
        }
        
        imageManager.requestImage(for: asset,
                                  targetSize: targetSize,
                                  contentMode: .aspectFit,
                                  options: options,
                                  resultHandler: resultHandler)
    }
    
}
