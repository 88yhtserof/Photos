//
//  AlbumViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit
import Photos

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
        let myAlbums: PHCollection?
        let mediaTypes: ListSampleData?
        
        init(myAlbums: PHCollection? = nil, mediaTypes: ListSampleData? = nil) {
            self.myAlbums = myAlbums
            self.mediaTypes = mediaTypes
        }
    }
}

extension AlbumViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func myAlbumCellRegistrationHandler(cell: GridListCell, indexPath: IndexPath, item: PHCollection) {
        let fetchResult = PHAsset.fetchAssets(in: item as! PHAssetCollection, options: nil)
        
        // TODO: - size 초기화 위치 변경
        let itemWidth = collectionView.collectionViewLayout.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))?.size.width ?? 0
        let thumbnailSize = CGSize(width: itemWidth, height: itemWidth)
        
        if let asset = fetchResult.firstObject {
            imageManager.requestImage(for: asset,
                                      targetSize: thumbnailSize,
                                      contentMode: .aspectFill,
                                      options: nil,
                                      resultHandler: { image, _ in
                cell.thumbnailImage = image
            })
        }
        cell.text = item.localizedTitle
        cell.secondaryText = String(fetchResult.count)
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
        let mediaTypes = ListSampleData.listSample.map{ Item(mediaTypes: $0) }
        let myAlbums = fetchAssetCollectionsForMyAlbum()
        
        snapshot = Snapshot()
        snapshot.appendSections([.myAlbum, .mediaTypes])
        snapshot.appendItems(myAlbums, toSection: .myAlbum)
        snapshot.appendItems(mediaTypes, toSection: .mediaTypes)
        dataSouce.apply(snapshot)
    }
    
    func updateSnapshot(to section: Section) {
        var items: [Item] = []
        switch section {
        case .myAlbum:
            items = fetchAssetCollectionsForMyAlbum()
        case .mediaTypes:
            items = ListSampleData.listSample.map{ Item(mediaTypes: $0) }
        }
        snapshot.appendItems(items, toSection: section)
        dataSouce.apply(snapshot)
    }
    
    private func fetchAssetCollectionsForMyAlbum() -> [Item] {
        guard let recentCount = recentFetchResult?.count,
              let recentCollections = recentFetchResult?.objects(at: IndexSet(0..<recentCount)),
              let favoriteCount = favoriteFetchResult?.count,
              let favoriteCollections = favoriteFetchResult?.objects(at: IndexSet(0..<favoriteCount)) else {
            fatalError("Failed to fetch collections as UserLibrary and Favorites")
        }
        var items = recentCollections.map{ Item(myAlbums: $0) }
        items.append(contentsOf: favoriteCollections.map{ Item(myAlbums: $0) })
        
        if let userCollectionCount = userFetchResult?.count,
           let userCollections = userFetchResult?.objects(at: IndexSet(0..<userCollectionCount)) {
            items.append(contentsOf: userCollections.map{ Item(myAlbums: $0) })
        }
        
        return items
    }
}
