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
        let size = CGSize(width: 100, height: 100)
        if let asset = fetchResult.firstObject {
            imageManager.requestImage(for: asset,
                                      targetSize: size,
                                      contentMode: .aspectFit,
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
        snapshot = Snapshot()
        snapshot.appendSections([.myAlbum, .mediaTypes])
        
        if let count = userCollections?.count,
           let collections = userCollections?.objects(at: IndexSet(0..<count)) {
            let list = collections.map{ Item(myAlbums: $0) }
            snapshot.appendItems(list, toSection: .myAlbum)
        }
        snapshot.appendItems(mediaTypes, toSection: .mediaTypes)
        dataSouce.apply(snapshot)
    }
    
    func updateSnapshot(to section: Section) {
        var items: [Item] = []
        switch section {
        case .myAlbum:
            if let count = userCollections?.count,
               let collections = userCollections?.objects(at: IndexSet(0..<count)) {
                items = collections.map{ Item(myAlbums: $0) }
            }
        case .mediaTypes:
            items = ListSampleData.listSample.map{ Item(mediaTypes: $0) }
        }
        snapshot.appendItems(items, toSection: section)
        dataSouce.apply(snapshot)
    }
}
