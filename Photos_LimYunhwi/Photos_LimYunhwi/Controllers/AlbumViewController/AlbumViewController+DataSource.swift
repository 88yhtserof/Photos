//
//  AlbumViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

extension AlbumViewController {
    enum Section {
        case myAlbum
        case mediaTypes
    }
    
    struct Item: Hashable {
        let myAlbums: SampleData? //임시
        let mediaTypes: String?
        
        init(myAlbums: SampleData? = nil, mediaTypes: String? = nil) {
            self.myAlbums = myAlbums
            self.mediaTypes = mediaTypes
        }
    }
}

extension AlbumViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func cellRegistrationHandler(cell: GridListCell, indexPath: IndexPath, item: Item) {
        Task {
            let image = try await ImageLoader.loadImage(from: URL(string: item.myAlbums!.thumnailURL)!)
            cell.thumbnailImage = image
            cell.text = item.myAlbums!.albumTitle
            cell.secondaryText = item.myAlbums!.numberOfAlbums
        }
    }
    
    func updateSnapshot() {
        let list = SampleData.sample.map{ Item(myAlbums: $0) }
        var snapshot = Snapshot()
        snapshot.appendSections([.myAlbum])
        snapshot.appendItems(list, toSection: .myAlbum)
        dataSouce.apply(snapshot)
        
    }
}
