//
//  UIColor+.swift
//  DoneList
//
//  Created by dudu on 2022/08/03.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        let allColor: [UIColor] = [.systemBlue, .systemRed, .systemBrown, .systemIndigo, .systemGray, .systemCyan, .systemTeal, .systemMint, .systemPurple]
        
        return allColor.randomElement() ?? .systemBlue
    }
}
