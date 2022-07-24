//
//  DoneChartViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import Foundation
import Combine

protocol DoneChartViewModelInput {
    
}

protocol DoneChartViewModelOutput {
    
}

protocol DoneChartViewModelType: DoneChartViewModelInput, DoneChartViewModelOutput {}

final class DoneChartViewModel: DoneChartViewModelType {
    private let doneUseCase: DoneUseCase
    private let targetDate: Date
    private var cancelBag = Set<AnyCancellable>()
    
    init(doneUseCase: DoneUseCase, targetDate: Date) {
        self.doneUseCase = doneUseCase
        self.targetDate = targetDate
    }
}

fileprivate func findWeeks(_ date: Date) -> [Date] {
    let calendar = Calendar.current
    let date = calendar.startOfDay(for: date)
    let weekIndex = calendar.dateComponents([.weekday], from: date).weekday!
    
    let interval = Double((weekIndex + 7 - 2) % 7)
    let monday = Date(timeInterval: -86400 * interval, since: date)
    
    return (0..<7).map {Double($0 * 86400)}
        .compactMap(monday.addingTimeInterval)
}
