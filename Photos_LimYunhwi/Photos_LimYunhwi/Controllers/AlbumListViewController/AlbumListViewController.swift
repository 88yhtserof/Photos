//
//  AlbumListViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit
import Photos

class AlbumListViewController: UIViewController {
    
    var imageManager = PHImageManager()
    var favoriteFetchResult: PHFetchResult<PHAssetCollection>?
    var recentFetchResult: PHFetchResult<PHAssetCollection>?
    var livephotoFetchResult: PHFetchResult<PHAssetCollection>?
    var selfieFetchResult: PHFetchResult<PHAssetCollection>?
    var userFetchResult: PHFetchResult<PHAssetCollection>?
    var dataSouce: DataSource!
    var snapshot: Snapshot!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureView()
        configurePhotoLibrary()
        configureDataSource()
    }
}

// MARK: Configuration
private extension AlbumListViewController {
    func configureSubviews() {
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: -10)
        collectionView.delegate = self
    }
    
    func configureView() {
        navigationItem.title = "앨범"
        navigationItem.largeTitleDisplayMode = .automatic
        
        view.backgroundColor = .white
        view.addPinnedSubview(collectionView, height: nil)
    }
    
    func configureDataSource() {
        let myAlbumCellRegistration = UICollectionView.CellRegistration(handler: myAlbumCellRegistrationHandler)
        let mediaTypesCellRegistration = UICollectionView.CellRegistration(handler: mediaTypesCellRegistrationHandler)
        
        dataSouce = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section")
            }
            switch section {
            case .myAlbum:
                return collectionView.dequeueConfiguredReusableCell(using: myAlbumCellRegistration, for: indexPath, item: itemIdentifier.myAlbums)
            case .mediaTypes:
                return collectionView.dequeueConfiguredReusableCell(using: mediaTypesCellRegistration, for: indexPath, item: itemIdentifier.mediaTypes)
            }
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration(elementKind: Supplementary.title
            .name, handler: supplementaryRegistrationHandler)
        dataSouce.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        
        updateSnapshot()
        collectionView.dataSource = dataSouce
    }
    
    func configurePhotoLibrary() {
        PHPhotoLibrary.shared().register(self)
        
        favoriteFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        recentFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        userFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        livephotoFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumLivePhotos, options: nil)
        selfieFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSelfPortraits, options: nil)
    }
}
