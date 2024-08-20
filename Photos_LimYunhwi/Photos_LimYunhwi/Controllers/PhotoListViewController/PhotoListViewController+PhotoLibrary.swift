//
//  PhotoListViewController+PhotoLibrary.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import Foundation
import Photos

//MARK: PhotoLibraryChangeObserver
extension PhotoListViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        Task { @MainActor in
            if let changes = changeInstance.changeDetails(for: fetchResult) {
                fetchResult = changes.fetchResultAfterChanges
                updateSnapshot()
            }
        }
    }
}
