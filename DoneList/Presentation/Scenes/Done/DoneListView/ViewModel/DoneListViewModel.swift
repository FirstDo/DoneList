//
//  DoneListViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

protocol DoneListViewModelInput {
    func didTapChartButton()
    func didTapSettingButton()
    func didTapYesterDayButton()
    func didTapTomorrowButton()
    func didTapDateLabel()
    func didTapCell(with item: Done)
    func didTapAddButton()
}

protocol DoneListViewModelOutput {
    var doneItems: AnyPublisher<[Done], Never> { get }
    var quote: AnyPublisher<Quote, Never> { get }
    var dateTitle: AnyPublisher<String, Never> { get }
    
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var showChartView: PassthroughSubject<Void, Never> { get }
    var showSettingView: PassthroughSubject<Void, Never> { get }
    var showCalendarView: PassthroughSubject<Date, Never> { get }
    var showDoneEditView: PassthroughSubject<Done, Never> { get }
    var showDoneCreateView: PassthroughSubject<Void, Never> { get }
}

protocol DoneListViewModelType: DoneListViewModelInput, DoneListViewModelOutput {}

final class DoneListViewModel:  DoneListViewModelType {
    private let doneUseCase: DoneUseCaseType
    private let fetchQuoteUseCase: FetchQuoteUseCaseType
    private var cancelBag = Set<AnyCancellable>()
    
    @Published private var currentDate: Date = .now
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "YYYY.MM.dd"
        
        return formatter
    }()
    
    // MARK: - OutPut
    
    var doneItems: AnyPublisher<[Done], Never> {
        return doneUseCase.fetchAllItem()
    }
    
    var dateTitle: AnyPublisher<String, Never> {
        return $currentDate
            .map { self.dateFormatter.string(from: $0) }
            .eraseToAnyPublisher()
    }
    
    var quote: AnyPublisher<Quote, Never> {
        return fetchQuoteUseCase
            .fetchQuote()
            .replaceError(with: Quote(quote: "인터넷에 연결해주세요 :("))
            .eraseToAnyPublisher()
    }
    
    let showErrorAlert = PassthroughSubject<String, Never>()
    let showChartView = PassthroughSubject<Void, Never>()
    let showSettingView = PassthroughSubject<Void, Never>()
    let showCalendarView = PassthroughSubject<Date, Never>()
    let showDoneEditView = PassthroughSubject<Done, Never>()
    let showDoneCreateView = PassthroughSubject<Void, Never>()
    
    init(doneUseCase: DoneUseCaseType, fetchQuoteUseCase: FetchQuoteUseCaseType) {
        self.doneUseCase = doneUseCase
        self.fetchQuoteUseCase = fetchQuoteUseCase
    }
}

// MARK: - Input

extension DoneListViewModel {
    func didTapChartButton() {
        showChartView.send(())
    }
    
    func didTapSettingButton() {
        showSettingView.send(())
    }
    
    func didTapYesterDayButton() {
        guard let dayBefore = currentDate.dayBefore else { return }
        
        currentDate = dayBefore
    }
    
    func didTapTomorrowButton() {
        guard let dayAfter = currentDate.dayBefore else { return }
        
        currentDate = dayAfter
    }
    
    func didTapDateLabel() {
        showCalendarView.send(currentDate)
    }
    
    func didTapCell(with item: Done) {
        showDoneEditView.send(item)
    }
    
    func didTapAddButton() {
        showDoneCreateView.send(())
    }
}

// MARK: - Logic

fileprivate extension Date {
    var dayBefore: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    
    var dayAfter: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
