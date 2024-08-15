//
//  AlbumViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

extension AlbumViewController {
    enum Section: Int {
        
        case myAlbum
        case mediaTypes
        
        var title: String {
            switch self {
            case .myAlbum:
                return "나의 앨범"
            case .mediaTypes:
                return "미디어 유형"
            }
        }
    }
    
    struct Item: Hashable {
        let myAlbums: GridSampleData? //임시
        let mediaTypes: ListSampleData?
        
        init(myAlbums: GridSampleData? = nil, mediaTypes: ListSampleData? = nil) {
            self.myAlbums = myAlbums
            self.mediaTypes = mediaTypes
        }
    }
}

extension AlbumViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func myAlbumCellRegistrationHandler(cell: GridListCell, indexPath: IndexPath, item: Item) {
        Task {
            let image = try await ImageLoader.loadImage(from: URL(string: item.myAlbums!.thumnailURL)!)
            cell.thumbnailImage = image
            cell.text = item.myAlbums!.albumTitle
            cell.secondaryText = item.myAlbums!.numberOfAlbums
        }
    }
    
    func mediaTypesCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, item: ListSampleData) {
        var configuration = UIListContentConfiguration.valueCell()
        configuration.image = UIImage(systemName: item.type.name)
        configuration.text = item.type.name
        configuration.secondaryText = String(item.numberOfPhotos)
        
        cell.contentConfiguration = configuration
        cell.accessories = [.disclosureIndicator()]
    }
    
    func supplementaryRegistrationHandler(supplementaryView: TitleSupplementaryView, string: String, indexPath: IndexPath) {
        supplementaryView.title = snapshot.sectionIdentifiers[indexPath.section].title
    }
    
    func updateSnapshot() {
        let list = GridSampleData.gridSample.map{ Item(myAlbums: $0) }
        let mediaTypes = ListSampleData.listSample.map{ Item(mediaTypes: $0) }
        snapshot = Snapshot()
        snapshot.appendSections([.myAlbum, .mediaTypes])
        snapshot.appendItems(list, toSection: .myAlbum)
        snapshot.appendItems(mediaTypes, toSection: .mediaTypes)
        dataSouce.apply(snapshot)
        
    }
}
