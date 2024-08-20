//
//  GridImageListCell.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/18/24.
//

import UIKit

/// Grid shape list cell with only image
class GridImageListCell: UICollectionViewCell {
    
    var assetIdentifier: String?
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

//MARK: Configuration
private extension GridImageListCell {
    
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
    }
    
    func configureConstraints() {
        contentView.addPinnedSubview(imageView, height: nil)
    }
}
