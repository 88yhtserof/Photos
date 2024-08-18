//
//  PhotoListViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit
import Photos

class PhotoListViewController: UIViewController {
    
    var assetCollection: PHAssetCollection
    
    init(assetCollection: PHAssetCollection) {
        self.assetCollection = assetCollection
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
