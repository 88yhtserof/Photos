//
//  GridTextListCell.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

/// Grid shape list cell with text and image
class GridTextListCell: UICollectionViewCell, Identifiable {
    typealias ID = String?
    
    var id: String?
    var thumbnailImage: UIImage? {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        textLabel.text = nil
        secondaryTextLabel.text = nil
    }

}

// MARK: Configuration
private extension GridTextListCell {
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        
        textLabel.font = .systemFont(ofSize: 15, weight: .regular)
        secondaryTextLabel.font = .systemFont(ofSize: 15, weight: .thin)
    }
    
    func configureContentView() {
        contentView.addSubviews([imageView, textLabel, secondaryTextLabel])
    }
    
    func configureConstraints() {
        let spacing: CGFloat = 5.0
        let height = contentView.frame.width
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: height),
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
