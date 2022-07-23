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
    let imageName: String
    
    init(id: String = UUID().uuidString, createdAt: Date, taskName: String, imageName: String) {
        self.id = id
        self.createdAt = createdAt
        self.taskName = taskName
        self.imageName = imageName
    }
}

#if DEBUG
extension Done {
    static func dummy() -> [Done] {
        let oneDay: TimeInterval = 86_400
        
        let today = Date.now
        let yesterDay = today.addingTimeInterval(-oneDay)
        let tomorrow = today.addingTimeInterval(oneDay)
        let oneMonthBefore = today.addingTimeInterval(-oneDay * 30)
        let oneMonthAfter = today.addingTimeInterval(oneDay * 30)
        
        return [
            Done(createdAt: today, taskName: "iOS 공부를 했다", imageName: "iphone.homebutton"),
            Done(createdAt: yesterDay, taskName: "유튜브를 봤다", imageName: "play.rectangle.fill"),
            Done(createdAt: tomorrow, taskName: "운동을 했다", imageName: "heart.fill"),
            Done(createdAt: oneMonthBefore, taskName: "게임을 했다!!", imageName: "gamecontroller.fill"),
            Done(createdAt: oneMonthAfter, taskName: "회사에 갔다!! 그리고 매우매우 매우 매우 긴 레이블입니다", imageName: "building.2"),
        ]
    }
}
#endif
