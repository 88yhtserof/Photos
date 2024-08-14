//
//  UIView+Constratins.swift
//  Photos_LimYunhwi
//
//  Created by 임윤휘 on 8/14/24.
//

import UIKit

extension UIView {
    
    /// Adds views to the end of the receiver’s list of subviews, determining their autoresizing mask isn't translated into Auto Layout constraints.
    func addSubviews(_ views: [UIView]) {
        views
            .forEach{
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
    }
    
    /// Adds a view and define constraints to the view.
    func addPinnedSubview(_ view: UIView, inset: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), height: CGFloat?) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset.top),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: inset.bottom),
            view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset.left),
            view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: inset.right)
        ])

        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
