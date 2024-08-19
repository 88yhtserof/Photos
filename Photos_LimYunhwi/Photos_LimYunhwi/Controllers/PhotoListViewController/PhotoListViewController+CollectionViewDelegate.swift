//
//  PhotoListViewController+CollectionViewDelegate.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import UIKit

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = fetchResult.object(at: indexPath.row)
        print("Select", asset)
        
    }
}
