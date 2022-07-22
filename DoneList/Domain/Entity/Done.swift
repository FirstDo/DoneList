//
//  Done.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation

struct Done: Hashable {
    let id: String
    let taskName: String
    let imageName: String
    
    init(id: String = UUID().uuidString, taskName: String, imageName: String) {
        self.id = id
        self.taskName = taskName
        self.imageName = imageName
    }
}

#if DEBUG
extension Done {
    static func dummy() -> [Done] {
        return [
            Done(taskName: "iOS 공부를 했다", imageName: "iphone.homebutton"),
            Done(taskName: "유튜브를 봤다", imageName: "play.rectangle.fill"),
            Done(taskName: "운동을 했다", imageName: "heart.fill"),
            Done(taskName: "게임을 했다!!", imageName: "gamecontroller.fill"),
            Done(taskName: "회사에 갔다", imageName: "building.2"),
        ]
    }
}
#endif
