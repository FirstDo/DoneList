//
//  DoneChartViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import Foundation
import Combine

protocol DoneChartViewModelInput {
    func didTapYesterDayButton()
    func didTapTomorrowButton()
}

protocol DoneChartViewModelOutput {
    var dateTitle: AnyPublisher<String, Never> { get }
    var weekIndexTitle: AnyPublisher<[String], Never> { get }
}

protocol DoneChartViewModelType: DoneChartViewModelInput, DoneChartViewModelOutput {}

final class DoneChartViewModel: DoneChartViewModelType {
    private let doneUseCase: DoneUseCaseType
    @Published private var targetDate: Date
    private var cancelBag = Set<AnyCancellable>()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MM.dd"
        
        return formatter
    }()
    
    // MARK: - Output
    
    var dateTitle: AnyPublisher<String, Never> {
        return $targetDate
            .map { findWeeks($0) }
            .map { self.dateFormatter.string(from: $0.first!) + "~" + self.dateFormatter.string(from: $0.last!) }
            .eraseToAnyPublisher()
    }
    
    var weekIndexTitle: AnyPublisher<[String], Never> {
        return $targetDate
            .map (findWeeks(_:))
            .map { $0.map { self.dateFormatter.string(from: $0) }}
            .eraseToAnyPublisher()
    }
    
    init(doneUseCase: DoneUseCaseType, targetDate: Date) {
        self.doneUseCase = doneUseCase
        self.targetDate = targetDate
    }
}

// MARK: - Input

extension DoneChartViewModel {
    func didTapYesterDayButton() {
        targetDate.addTimeInterval(-86400 * 7)
    }
    
    func didTapTomorrowButton() {
        targetDate.addTimeInterval(86400 * 7)
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
