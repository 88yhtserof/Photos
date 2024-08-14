//
//  AlbumViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureView()
    }
}

// MARK: Configuration
private extension AlbumViewController {
    func configureSubviews() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addPinnedSubview(collectionView, inset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), height: nil)
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
        
        return section
    }
}
