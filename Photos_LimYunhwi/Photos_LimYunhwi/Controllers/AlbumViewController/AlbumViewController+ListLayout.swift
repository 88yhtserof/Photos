//
//  AlbumViewController+ListLayout.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/16/24.
//

import UIKit

// MARK: CollectionView Layout
extension AlbumViewController {
    
    enum Supplementary: String {
        case title = "title-element-kind"
        
        var name: String {
            self.rawValue
        }
    }
    
    func layout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProviderHandler, configuration: configuration)
    }
    
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
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: Supplementary.title
            .name, alignment: .top)
    }
}
