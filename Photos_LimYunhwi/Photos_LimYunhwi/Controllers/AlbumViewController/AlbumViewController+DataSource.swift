//
//  AlbumViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

extension AlbumViewController {
    enum Section: String {
        case myAlbum = "나의 앨범"
        case mediaTypes = "미디어 유형"
        
        var title: String {
            self.rawValue
        }
    }
    
    struct Item: Hashable {
        let myAlbums: GridSampleData? //임시
        let mediaTypes: String?
        
        init(myAlbums: GridSampleData? = nil, mediaTypes: String? = nil) {
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
    
    func supplementaryRegistrationHandler(supplementaryView: TitleSupplementaryView, string: String, indexPath: IndexPath) {
        supplementaryView.title = snapshot.sectionIdentifiers[indexPath.section].title
    }
    
    func updateSnapshot() {
        let list = GridSampleData.gridSample.map{ Item(myAlbums: $0) }
        snapshot = Snapshot()
        snapshot.appendSections([.myAlbum])
        snapshot.appendItems(list, toSection: .myAlbum)
        dataSouce.apply(snapshot)
        
    }
}
