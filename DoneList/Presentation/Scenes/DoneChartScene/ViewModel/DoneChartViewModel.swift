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
    var graphValues: AnyPublisher<[(taskCount: Int, totalTaskCount: Int)], Never> { get }
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
            .map { date in
                date.findWeeks
            }
            .map { self.dateFormatter.string(from: $0.first!) + "~" + self.dateFormatter.string(from: $0.last!) }
            .eraseToAnyPublisher()
    }
    
    var weekIndexTitle: AnyPublisher<[String], Never> {
        return $targetDate
            .map { date in
                date.findWeeks
            }
            .map { $0.map { self.dateFormatter.string(from: $0) }}
            .eraseToAnyPublisher()
    }
    
    var graphValues: AnyPublisher<[(taskCount: Int, totalTaskCount: Int)], Never> {
        return $targetDate
            .flatMap { date in
                self.doneUseCase.fetchItmes(for: date.findWeeks)
                    .compactMap { dicts -> [(taskCount: Int, totalTaskCount: Int)] in
                        let maxValue = dicts.values.map { $0.count }.max()!
                        return date.findWeeks.map { (dicts[$0]!.count, maxValue) }
                    }
            }
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
