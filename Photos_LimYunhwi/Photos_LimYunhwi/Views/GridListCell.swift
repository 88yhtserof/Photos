//
//  GridListCell.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

class GridListCell: UICollectionViewCell {
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    var text: String! {
        didSet {
            textLabel.text = text
        }
    }
    var secondaryText: String? {
        didSet {
            secondaryTextLabel.text = secondaryText
        }
    }
    
    private lazy var imageView = UIImageView()
    private lazy var textLabel = UILabel()
    private lazy var secondaryTextLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureContentView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration
private extension GridListCell {
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        textLabel.font = .systemFont(ofSize: 15, weight: .regular)
        secondaryTextLabel.font = .systemFont(ofSize: 15, weight: .thin)
    }
    
    func configureContentView() {
        contentView.addSubviews([imageView, textLabel, secondaryTextLabel])
    }
    
    func configureConstraints() {
        let spacing: CGFloat = 5.0
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            secondaryTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            secondaryTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secondaryTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondaryTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
