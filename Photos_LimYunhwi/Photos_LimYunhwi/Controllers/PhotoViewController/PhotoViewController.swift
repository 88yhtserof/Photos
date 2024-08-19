//
//  PhotoViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    var asset: PHAsset
    
    lazy var imageView = UIImageView()
    lazy var progressView = UIProgressView()
    
    init(asset: PHAsset) {
        self.asset = asset
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureView()
        configureConstraints()
    }
}

private extension PhotoViewController {
    
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFit
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        view.addPinnedSubview(imageView, height: nil)
        view.addSubviews([progressView])
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            progressView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
