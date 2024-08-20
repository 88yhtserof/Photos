//
//  PhotoListViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

final class PhotoListViewController: UIViewController {
    
    var dataSource: DataSource!
    var snapshot: Snapshot!
    
    let imageManager = ImageManager()
    
    var fetchResult: PHFetchResult<PHAsset>
    let albumTitle: String?
    var photoSize: CGSize!
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    init(assetCollection: PHAssetCollection) {
        self.fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
        self.albumTitle = assetCollection.localizedTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureView()
        configureConstratins()
        configurePhotoLibrary()
        configureDataSource()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let scale = view.window?.screen.scale ?? 1.0
        let itemWidth = collectionView.collectionViewLayout.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))?.size.width ?? 0
        photoSize = CGSize(width: itemWidth * scale, height: itemWidth * scale)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.scrollToItem(at: IndexPath(row: fetchResult.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
}

//MARK: Configuration
private extension PhotoListViewController {
    func configureSubviews() {
        collectionView.delegate = self
    }
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = albumTitle
    }
    
    func configureConstratins() {
        view.addPinnedSubview(collectionView, height: nil)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistraionHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        createSnapshot()
        collectionView.dataSource = dataSource
    }
    
    func configurePhotoLibrary() {
        PHPhotoLibrary.shared().register(self)
    }
}
