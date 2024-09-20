//
//  PhotoListViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

//MARK: DataSource
extension PhotoListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, PHAsset>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PHAsset>
    
    func cellRegistraionHandler(cell: GridImageListCell, indexPath: IndexPath, item: PHAsset) {
        
        cell.id = item.localIdentifier
        imageManager.requestImage(with: item,
                                  mode: .fastFormat,
                                  size: photoSize,
                                  resultHandler: { image, _ in
            if cell.id == item.localIdentifier {
                cell.image = image
            }
        })
    }
    
    func createSnapshot() {
        snapshot = Snapshot()
        snapshot.appendSections([0])
        updateSnapshot()
    }
    
    func updateSnapshot() {
        let items = fetchResult.objects(at: IndexSet(0..<fetchResult.count))
        
        let itemsBeforeChange = snapshot.itemIdentifiers
        if !itemsBeforeChange.isEmpty {
            snapshot.deleteItems(itemsBeforeChange)
        }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}
