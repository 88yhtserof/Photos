//
//  AlbumListViewController+PhotoLibrary.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/17/24.
//

import Foundation
import Photos

//MARK: PhotoLibraryChangeObserver
extension AlbumListViewController: PHPhotoLibraryChangeObserver {
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

//MARK: Photo Library
extension AlbumListViewController {
    
    enum MediaTypeImage: String {
        case livephoto = "Live Photos"
        case selfie = "Selfies"
        
        var name: String {
            switch self {
            case .livephoto:
                return "livephoto"
            case .selfie:
                return "person.crop.square"
            }
        }
    }
    
    func fetchAssetCollectionsForMyAlbum() -> [PHAssetCollection] {
        var myAlbums: [PHAssetCollection] = []
        
        if let recentCount = recentFetchResult?.count,
           let recentCollections = recentFetchResult?.objects(at: IndexSet(0..<recentCount)) {
            myAlbums.append(contentsOf: recentCollections)
        }
        if let favoriteCount = favoriteFetchResult?.count,
           let favoriteCollections = favoriteFetchResult?.objects(at: IndexSet(0..<favoriteCount)) {
            myAlbums.append(contentsOf: favoriteCollections)
        }
        if let userCollectionCount = userFetchResult?.count,
           let userCollections = userFetchResult?.objects(at: IndexSet(0..<userCollectionCount)) {
            myAlbums.append(contentsOf: userCollections)
        }
        
        return myAlbums
    }
    
    func fetchAssetCollectionsForMediaTypes() -> [PHAssetCollection] {
        var mediaTypes: [PHAssetCollection] = []
        
        if let livephotoAssetCollection = livephotoFetchResult?.firstObject {
            mediaTypes.append(livephotoAssetCollection)
        }
        if let selfieAssetCollection = selfieFetchResult?.firstObject {
            mediaTypes.append(selfieAssetCollection)
        }
        return mediaTypes
    }
}
