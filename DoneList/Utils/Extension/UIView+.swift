//
//  UIView+.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0)}
    }
}
