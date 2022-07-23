//
//  Category.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

struct Category: Hashable {
    let name: String
    
    static let all: [Category] = [
        Category(name: "books.vertical.fill"), // 독서
        Category(name: "moon.zzz"),
        Category(name: "cross.circle.fill"),
        Category(name: "paintpalette"),
        Category(name: "fork.knife"),
        Category(name: "gift"),
        Category(name: "message.circle"),
        Category(name: "rectangle.and.pencil.and.ellipsis"),
    ]
}
