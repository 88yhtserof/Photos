//
//  TitleSupplementaryView.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

/// Supplementary view with text for a title of list
class TitleSupplementaryView: UICollectionReusableView {
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Configuration
private extension TitleSupplementaryView {
    func configureSubviews() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func configureView() {
        addPinnedSubview(titleLabel, height: nil)
    }
}
