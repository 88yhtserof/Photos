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
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: -10)
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
                return collectionView.dequeueConfiguredReusableCell(using: myAlbumCellRegistration, for: indexPath, item: itemIdentifier)
            case .mediaTypes:
                return collectionView.dequeueConfiguredReusableCell(using: mediaTypesCellRegistration, for: indexPath, item: itemIdentifier.mediaTypes)
            }
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
    
    func sectionProviderHandler( sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        guard let section = Section(rawValue: sectionIndex) else {
            fatalError("Unknown Section")
        }
        switch section {
        case .myAlbum:
            return sectionForMyAlbum()
        case .mediaTypes:
            return sectionForMediaTypes(layoutEnvironment)
        }
    }
    
    func layout() -> UICollectionViewLayout {
        var configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProviderHandler, configuration: configuration)
    }
    
    func sectionForMyAlbum() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.48))
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(1.0))
        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(480))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, repeatingSubitem: item, count: 2)
        nestedGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, repeatingSubitem: nestedGroup, count: 2)
        containerGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [titleBoundarySupplementaryItem()]
        
        return section
    }
    
    func sectionForMediaTypes(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var configuaration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuaration.showsSeparators = true
        
        let section = NSCollectionLayoutSection.list(using: configuaration, layoutEnvironment: layoutEnvironment)
        section.boundarySupplementaryItems = [titleBoundarySupplementaryItem()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: -13, bottom: 0, trailing: 0)
        
        return section
    }
    
    func titleBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: titleElementKind, alignment: .top)
    }
}
