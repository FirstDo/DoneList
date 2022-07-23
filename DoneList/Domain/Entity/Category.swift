//
//  Category.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

struct Category: Hashable {
    let name: String
    let color: UIColor
    
    static let empty = Category(name: "plus", color: .systemGray)
    
    static let all: [Category] = [
        Category(name: "books.vertical.fill", color: .systemRed), // 독서
        Category(name: "moon.zzz", color: .systemBlue),
        Category(name: "cross.circle.fill", color: .systemGreen),
        Category(name: "paintpalette", color: .systemYellow),
        Category(name: "fork.knife", color: .systemTeal),
        Category(name: "gift", color: .systemCyan),
        Category(name: "message.circle", color: .systemMint),
        Category(name: "rectangle.and.pencil.and.ellipsis", color: .systemBrown),
    ]
}
