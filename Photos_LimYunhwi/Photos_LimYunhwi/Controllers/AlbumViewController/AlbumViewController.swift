//
//  AlbumViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

class AlbumViewController: UIViewController {
    
    enum Supplementary: String {
        case title = "title-element-kind"
        
        var name: String {
            self.rawValue
        }
    }
    
    var dataSouce: DataSource!
    var snapshot: Snapshot!
    let titleElementKind = "title-element-kind"
    
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
