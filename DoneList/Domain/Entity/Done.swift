//
//  Done.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation

struct Done: Hashable {
    let id: String
    let createdAt: Date
    let taskName: String
    let category: Category
    
    init(id: String = UUID().uuidString, createdAt: Date, taskName: String, category: Category) {
        self.id = id
        self.createdAt = createdAt
        self.taskName = taskName
        self.category = category
    }
}

#if DEBUG
extension Done {
    static func dummy() -> [Done] {
        let today = Date.now.startOfDay
        
        return [
            Done(createdAt: today, taskName: "샤워", category: Category(name: "bath")),
            Done(createdAt: today, taskName: "체크", category: Category(name: "check")),
            Done(createdAt: today, taskName: "청소", category: Category(name: "clean")),
            Done(createdAt: today, taskName: "커피", category: Category(name: "coffee")),
            Done(createdAt: today, taskName: "컴퓨터", category: Category(name: "computer")),
            Done(createdAt: today, taskName: "식사", category: Category(name: "dinner")),
            Done(createdAt: today, taskName: "운동", category: Category(name: "exercise")),
            Done(createdAt: today, taskName: "음식", category: Category(name: "food")),
            Done(createdAt: today, taskName: "게임", category: Category(name: "game")),
            Done(createdAt: today, taskName: "인스타", category: Category(name: "instagram")),
            Done(createdAt: today, taskName: "카카오톡", category: Category(name: "kakaotalk")),
            Done(createdAt: today, taskName: "여행", category: Category(name: "passport")),
            Done(createdAt: today, taskName: "폰", category: Category(name: "phone")),
            Done(createdAt: today, taskName: "독서", category: Category(name: "reading")),
            Done(createdAt: today, taskName: "쇼핑", category: Category(name: "shopping")),
            Done(createdAt: today, taskName: "스터디", category: Category(name: "study")),
            Done(createdAt: today, taskName: "지하철", category: Category(name: "subway")),
            Done(createdAt: today, taskName: "티비", category: Category(name: "tv")),
            Done(createdAt: today, taskName: "업무", category: Category(name: "work")),
            Done(createdAt: today, taskName: "요가", category: Category(name: "yoga")),
            Done(createdAt: today, taskName: "유튜브", category: Category(name: "youtube"))
        ]
    }
}
#endif
