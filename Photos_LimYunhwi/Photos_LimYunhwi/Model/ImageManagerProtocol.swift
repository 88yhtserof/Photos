//
//  ImageManagerProtocol.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/20/24.
//

import UIKit
import Photos

protocol ImageManagerProtocol {
    func requestImage(with asset: PHAsset, mode deliveryMode: PHImageRequestOptionsDeliveryMode, size targetSize: CGSize, progressHandler: PHAssetImageProgressHandler?, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void)
}
