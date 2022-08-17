//
//  UIStackView+.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
