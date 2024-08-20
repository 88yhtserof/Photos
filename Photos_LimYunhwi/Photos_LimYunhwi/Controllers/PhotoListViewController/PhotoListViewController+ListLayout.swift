//
//  PhotoListViewController+ListLayout.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/20/24.
//

import UIKit

// MARK: CollectionView Layout
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
