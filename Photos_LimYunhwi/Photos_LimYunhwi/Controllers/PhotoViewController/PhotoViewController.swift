//
//  PhotoViewController.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/19/24.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    
    let imageManager = PHImageManager()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureImageView()
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
    
    func configureImageView() {
        let option = PHImageRequestOptions()
        option.deliveryMode = .opportunistic
        option.isNetworkAccessAllowed = true
        option.progressHandler = { progress, _, _, info in
            Task { @MainActor in
                self.progressView.progress = Float(progress)
            }
        }
        
        let scale = view.window?.screen.scale ?? 1.0
        let size = CGSize(width: imageView.bounds.width * scale,
                          height: imageView.bounds.height * scale)
        
        imageManager.requestImage(for: asset,
                                  targetSize: size,
                                  contentMode: .aspectFit,
                                  options: option,
                                  resultHandler: { image, info in
            guard let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool else { return }
            
            if isDegraded && self.imageView.image == nil {
                self.imageView.image = image
            }
            if !isDegraded {
                self.imageView.image = image
                self.progressView.isHidden = true
            }
        })
    }
    
}
