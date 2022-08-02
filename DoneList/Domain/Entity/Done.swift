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
            Done(createdAt: today, taskName: "iOS 공부를 했다", category: Category(name: "study")),
            Done(createdAt: today.dayAfter, taskName: "유튜브를 봤다", category: Category(name: "youtube")),
            Done(createdAt: today.dayBefore, taskName: "운동을 했다", category: Category(name: "exercise")),
            Done(createdAt: today, taskName: "게임을 했다!!", category: Category(name: "game")),
            Done(createdAt: today, taskName: "회사에 갔다!! 그리고 매우매우 매우 매우 긴 레이블입니다", category: Category(name: "work"))
        ]
    }
}
#endif
