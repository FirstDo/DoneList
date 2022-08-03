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
    
    init(name: String, color: UIColor = .randomColor) {
        self.name = name
        self.color = color
    }
    
    static let empty = Category(name: "add.circle", color: .systemGray)
    
    static let all: [Category] = [
        Category(name: "bath"),
        Category(name: "check"),
        Category(name: "clean"),
        Category(name: "coffee"),
        Category(name: "computer"),
        Category(name: "dinner"),
        Category(name: "exercise"),
        Category(name: "food"),
        Category(name: "game"),
        Category(name: "instagram"),
        Category(name: "kakaotalk"),
        Category(name: "passport"),
        Category(name: "phone"),
        Category(name: "reading"),
        Category(name: "shopping"),
        Category(name: "study"),
        Category(name: "subway"),
        Category(name: "tv"),
        Category(name: "work"),
        Category(name: "yoga"),
        Category(name: "youtube")
    ]
}
