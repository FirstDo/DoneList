//
//  DoneDummy.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList
import Foundation

extension Done {
    static var testDummy: [Done] {
        var date = Date.now.startOfDay
        
        return (0..<100).map { index -> Done in
            date = date.dayAfter
            return Done(createdAt: date, taskName: "\(index)", category: .empty)
        }
    }
}
