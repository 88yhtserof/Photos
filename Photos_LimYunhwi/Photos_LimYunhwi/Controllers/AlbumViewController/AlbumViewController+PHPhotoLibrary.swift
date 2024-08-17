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
            if userFetchResult != nil,
               let albumChanges = changeInstance.changeDetails(for: userFetchResult!) {
                userFetchResult = albumChanges.fetchResultAfterChanges
                updateSnapshot(to: .myAlbum)
            }
        }
    }
}
