//
//  AlbumViewController+PHPhotoLibrary.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/17/24.
//

import Foundation
import Photos

extension AlbumViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        Task { @MainActor in
            if userCollections != nil,
               let albumChanges = changeInstance.changeDetails(for: userCollections!) {
                userCollections = albumChanges.fetchResultAfterChanges
                updateSnapshot(to: .myAlbum)
            }
        }
    }
}
