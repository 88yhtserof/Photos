//
//  PhotoListViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

class PhotoListViewController: UIViewController {
    
    let imageManager = PHImageManager()
    var fetchResult: PHFetchResult<PHAsset>
    var dataSource: DataSource!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    init(assetCollection: PHAssetCollection) {
        self.fetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
        
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
        configureDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.scrollToItem(at: IndexPath(row: fetchResult.count - 1, section: 0), at: .bottom, animated: false)
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
    }
    
    func configureConstratins() {
        view.addPinnedSubview(collectionView, height: nil)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistraionHandler)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
}

extension PhotoListViewController {
    func layout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(3)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 3
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
