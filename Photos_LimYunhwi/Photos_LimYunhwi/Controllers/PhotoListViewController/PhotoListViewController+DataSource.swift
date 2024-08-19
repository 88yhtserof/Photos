//
//  PhotoListViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

extension PhotoListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, PHAsset>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PHAsset>
    
    func cellRegistraionHandler(cell: GridImageListCell, indexPath: IndexPath, item: PHAsset) {
        
        // TODO: - size 초기화 위치 변경
        let itemWidth = collectionView.collectionViewLayout.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))?.size.width ?? 0
        let size = CGSize(width: itemWidth, height: itemWidth)
        
        imageManager.requestImage(for: item, 
                                  targetSize: size,
                                  contentMode: .aspectFill,
                                  options: nil) { image, _ in
            cell.image = image
        }
    }
    
    func updateSnapshot() {
        let fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
        let items = fetchResult.objects(at: IndexSet(0..<fetchResult.count))
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}
