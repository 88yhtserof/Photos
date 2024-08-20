//
//  AlbumListViewController+DataSource.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit
import Photos

extension AlbumListViewController {
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
}

extension AlbumListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    func myAlbumCellRegistrationHandler(cell: GridTextListCell, indexPath: IndexPath, item: PHAssetCollection) {
        let fetchResult = PHAsset.fetchAssets(in: item, options: nil)
        
        if let asset = fetchResult.lastObject {
            cell.assetIdentifier = asset.localIdentifier
            imageManager.requestImage(with: asset,
                                      mode: .opportunistic,
                                      size: thumbnailSize,
                                      resultHandler: { image, _ in
                if cell.assetIdentifier == asset.localIdentifier {
                    cell.thumbnailImage = image
                }
            })
            cell.text = item.localizedTitle
            cell.secondaryText = String(fetchResult.count)
        }
    }
    
    func mediaTypesCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, item: PHAssetCollection) {
        cell.selectedBackgroundView = UIView()
        
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
}
