//
//  AlbumListViewController+Delegate.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

//MARK: CollectionView Delegate
extension AlbumListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unknown Section")
        }
        var assetCollection: PHAssetCollection
        
        switch section {
        case .myAlbum:
            let myAlbums = fetchAssetCollectionsForMyAlbum()
            assetCollection = myAlbums[indexPath.row]
        case .mediaTypes:
            let mediaTypes = fetchAssetCollectionsForMediaTypes()
            assetCollection = mediaTypes[indexPath.row]
        }
        
        let photoListVC = PhotoListViewController(assetCollection: assetCollection)
        navigationController?.pushViewController(photoListVC, animated: true)
    }
}
