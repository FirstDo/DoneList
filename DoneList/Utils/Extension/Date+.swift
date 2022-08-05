//
//  Date+.swift
//  DoneList
//
//  Created by dudu on 2022/07/26.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var dayBefore: Date {
        return Date(timeInterval: -86_400, since: startOfDay)
    }
    
    var dayAfter: Date {
        return Date(timeInterval: 86_400, since: startOfDay)
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self.startOfDay)
        return Calendar.current.date(from: components) ?? .now
    }
    
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth) ?? .now
    }
    
    var findWeeks: [Date] {
        let weekIndex = Calendar.current.dateComponents([.weekday], from: startOfDay).weekday!
        let interval = Double((weekIndex + 7 - 2) % 7)
        let monday = Date(timeInterval: -86_400 * interval, since: startOfDay)
        
        return (0..<7).map {Double($0 * 86400)}
            .compactMap(monday.addingTimeInterval)
    }
}
