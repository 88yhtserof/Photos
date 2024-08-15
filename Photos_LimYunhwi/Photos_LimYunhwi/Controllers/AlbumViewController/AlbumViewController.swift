//
//  AlbumViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

class AlbumViewController: UIViewController {
    
    var dataSouce: DataSource!
    var snapshot: Snapshot!
    private let titleElementKind = "title-element-kind"
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureView()
        configureDataSource()
    }
}

// MARK: Configuration
private extension AlbumViewController {
    func configureSubviews() {
        
    }
    
    func configureView() {
        navigationItem.title = "앨범"
        navigationItem.largeTitleDisplayMode = .automatic
        
        view.backgroundColor = .white
        view.addPinnedSubview(collectionView, inset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), height: nil)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSouce = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration(elementKind: titleElementKind, handler: supplementaryRegistrationHandler)
        dataSouce.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        
        updateSnapshot()
        collectionView.dataSource = dataSouce
    }
}

// MARK: CollectionView Layout
private extension AlbumViewController {
    func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: sectionForMyAlbum())
        
        return layout
    }
    
    func sectionForMyAlbum() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.48))
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(1.0))
        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(500))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, repeatingSubitem: item, count: 2)
        nestedGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, repeatingSubitem: nestedGroup, count: 2)
        containerGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.boundarySupplementaryItems = [titleBoundarySupplementaryItem()]
        
        return section
    }
    
    func titleBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: titleElementKind, alignment: .top)
    }
}
