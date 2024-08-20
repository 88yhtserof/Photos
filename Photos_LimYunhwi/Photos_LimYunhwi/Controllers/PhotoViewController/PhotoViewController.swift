//
//  PhotoViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import UIKit
import Photos

final class PhotoViewController: UIViewController {
    
    let imageManager = ImageManager()
    var asset: PHAsset
    
    internal lazy var imageView = UIImageView()
    internal lazy var progressView = UIProgressView()
    
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let scale = view.window?.screen.scale ?? 1.0
        let size = CGSize(width: imageView.bounds.width * scale,
                          height: imageView.bounds.height * scale)
        
        imageManager.requestImage(with: asset,
                                  mode: .opportunistic,
                                  size: size,
                                  progressHandler: progressHandler,
                                  resultHandler: resultHandler)
    }
}

//MARK: Configuration
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
