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
    func didTapCloseButton()
}

protocol DoneChartViewModelOutput {
    var appFont: AppFont { get }
    var dateTitle: AnyPublisher<String, Never> { get }
    var weekIndexTitle: AnyPublisher<[String], Never> { get }
    var graphValues: AnyPublisher<[(taskCount: Int, totalTaskCount: Int)], Never> { get }
    
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol DoneChartViewModelType: DoneChartViewModelInput, DoneChartViewModelOutput {}

final class DoneChartViewModel: DoneChartViewModelType {
    private let doneUseCase: DoneUseCaseType
    @Published private var targetDate: Date
    private var cancelBag = Set<AnyCancellable>()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "M.d"
        
        return formatter
    }()
    
    // MARK: - Output
    
    let appFont: AppFont = FontManager.getFontName()
    
    var dateTitle: AnyPublisher<String, Never> {
        return $targetDate
            .map { date in
                date.findWeeks
            }
            .map { self.dateFormatter.string(from: $0.first!) + " ~ " + self.dateFormatter.string(from: $0.last!) }
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
    
    let showErrorAlert = PassthroughSubject<String, Never>()
    
    let dismissView = PassthroughSubject<Void, Never>()
    
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
        guard let lastDayOfWeek = targetDate.findWeeks.last, lastDayOfWeek <= Date.now.startOfDay else {
            return showErrorAlert.send("미래의 날짜는 선택할 수 없어요")
        }
        
        targetDate.addTimeInterval(86400 * 7)
    }
    
    func didTapCloseButton() {
        dismissView.send()
    }
}
