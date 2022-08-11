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
    
    init(realmDAO: DoneDAO) {
        self.id = realmDAO.id
        self.createdAt = realmDAO.createdAt
        self.taskName = realmDAO.taskName
        self.category = Category(name: realmDAO.categoryName)
    }
    
    func realmDAO() -> DoneDAO {
        let doneDAO = DoneDAO()
        doneDAO.id = id
        doneDAO.createdAt = createdAt
        doneDAO.taskName = taskName
        doneDAO.categoryName = category.name
        
        return doneDAO
    }
}

#if DEBUG
extension Done {
    static func dummy() -> [Done] {
        let today = Date.now.startOfDay
        
        return [
            Done(createdAt: today, taskName: "오늘 한 일을 적어보세요!", category: Category(name: "check")),
            Done(createdAt: today, taskName: "어떤 사소한 일이라도 좋습니다 :)", category: Category(name: "check")),
            Done(createdAt: today, taskName: "너무 길게 쓰지 않도록 조심하세요!", category: Category(name: "check")),
        ]
    }
}
#endif
