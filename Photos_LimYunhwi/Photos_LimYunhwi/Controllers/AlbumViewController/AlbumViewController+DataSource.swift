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
        let myAlbums: PHAssetCollection?
        let mediaTypes: PHAssetCollection?
        
        init(myAlbums: PHAssetCollection? = nil, mediaTypes: PHAssetCollection? = nil) {
            self.myAlbums = myAlbums
            self.mediaTypes = mediaTypes
        }
    }
    
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
}

extension AlbumViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func myAlbumCellRegistrationHandler(cell: GridListCell, indexPath: IndexPath, item: PHAssetCollection) {
        let fetchResult = PHAsset.fetchAssets(in: item, options: nil)
        
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
    
    func mediaTypesCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, item: PHAssetCollection) {
        let fetchResult = PHAsset.fetchAssets(in: item, options: nil)
        let albumTitle = item.localizedTitle ?? ""
        let imageName = MediaTypeImage(rawValue: albumTitle)?.name ?? ""
        
        var configuration = UIListContentConfiguration.valueCell()
        configuration.image = UIImage(systemName: imageName)
        configuration.text = albumTitle
        configuration.secondaryText = String(fetchResult.count)
        
        cell.contentConfiguration = configuration
        cell.accessories = [.disclosureIndicator()]
    }
    
    func supplementaryRegistrationHandler(supplementaryView: TitleSupplementaryView, string: String, indexPath: IndexPath) {
        supplementaryView.title = snapshot.sectionIdentifiers[indexPath.section].title
    }
    
    func updateSnapshot() {
        let myAlbums = fetchAssetCollectionsForMyAlbum()
        let myAlbumItems = myAlbums.map{ Item(myAlbums: $0) }
        let mediaTypes = fetchAssetCollectionsForMediaTypes()
        let mediaTypeItems = mediaTypes.map{ Item(mediaTypes: $0) }
        
        snapshot = Snapshot()
        snapshot.appendSections([.myAlbum, .mediaTypes])
        snapshot.appendItems(myAlbumItems, toSection: .myAlbum)
        snapshot.appendItems(mediaTypeItems, toSection: .mediaTypes)
        dataSouce.apply(snapshot)
    }
    
    func updateSnapshot(to section: Section) {
        var items: [Item] = []
        
        switch section {
        case .myAlbum:
            let myAlbums = fetchAssetCollectionsForMyAlbum()
            items = myAlbums.map{ Item(myAlbums: $0) }
        case .mediaTypes:
            let mediaTypes = fetchAssetCollectionsForMediaTypes()
            items = mediaTypes.map{ Item(mediaTypes: $0) }
        }
        snapshot.appendItems(items, toSection: section)
        dataSouce.apply(snapshot)
    }
    
    func fetchAssetCollectionsForMyAlbum() -> [PHAssetCollection] {
        guard let recentCount = recentFetchResult?.count,
              let recentCollections = recentFetchResult?.objects(at: IndexSet(0..<recentCount)),
              let favoriteCount = favoriteFetchResult?.count,
              let favoriteCollections = favoriteFetchResult?.objects(at: IndexSet(0..<favoriteCount)) else {
            fatalError("Failed to fetch collections as UserLibrary and Favorites")
        }
        var myAlbums = recentCollections
        myAlbums.append(contentsOf: favoriteCollections)
        
        if let userCollectionCount = userFetchResult?.count,
           let userCollections = userFetchResult?.objects(at: IndexSet(0..<userCollectionCount)) {
            myAlbums.append(contentsOf: userCollections)
        }
        
        return myAlbums
    }
    
    func fetchAssetCollectionsForMediaTypes() -> [PHAssetCollection] {
        guard let livephotoAssetCollection = livephotoFetchResult?.firstObject,
              let selfieAssetCollection = selfieFetchResult?.firstObject else {
            fatalError("Failed to fetch collections as LivePhoto and SelfPortraits")
        }
        let mediaTypes = [ livephotoAssetCollection, selfieAssetCollection ]
        return mediaTypes
    }
}
