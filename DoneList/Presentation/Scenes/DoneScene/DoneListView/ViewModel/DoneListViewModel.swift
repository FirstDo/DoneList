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
    func didCellSwipe(target item: Done)
    func didTapCell(with item: Done)
    func didTapAddButton()
    func didChangeTargetDate(to date: Date)
}

protocol DoneListViewModelOutput {
    var doneItems: AnyPublisher<[Done], Never> { get }
    var quote: AnyPublisher<Quote, Never> { get }
    var dateTitle: AnyPublisher<String, Never> { get }
    
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var showChartView: PassthroughSubject<Date, Never> { get }
    var showSettingView: PassthroughSubject<Void, Never> { get }
    var showCalendarView: PassthroughSubject<Date, Never> { get }
    var showDoneEditView: PassthroughSubject<Done, Never> { get }
    var showDoneCreateView: PassthroughSubject<Date, Never> { get }
}

protocol DoneListViewModelType: DoneListViewModelInput, DoneListViewModelOutput {}

final class DoneListViewModel: DoneListViewModelType {
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
            .combineLatest($currentDate)
            .compactMap { items, date in
                guard let startOfDay = date.startOfDay, let endOfDay = date.endOfDay else { return nil}
                
                return items.filter { (startOfDay...endOfDay) ~= $0.createdAt }
            }
            .eraseToAnyPublisher()
    }
    
    var dateTitle: AnyPublisher<String, Never> {
        return $currentDate
            .map { self.dateFormatter.string(from: $0) }
            .eraseToAnyPublisher()
    }
    
    var quote: AnyPublisher<Quote, Never> {
        return fetchQuoteUseCase
            .fetchQuote()
            .replaceError(with: Quote(content: "화이팅!", person: "나"))
            .eraseToAnyPublisher()
    }
    
    let showErrorAlert = PassthroughSubject<String, Never>()
    let showChartView = PassthroughSubject<Date, Never>()
    let showSettingView = PassthroughSubject<Void, Never>()
    let showCalendarView = PassthroughSubject<Date, Never>()
    let showDoneEditView = PassthroughSubject<Done, Never>()
    let showDoneCreateView = PassthroughSubject<Date, Never>()
    
    init(doneUseCase: DoneUseCaseType, fetchQuoteUseCase: FetchQuoteUseCaseType) {
        self.doneUseCase = doneUseCase
        self.fetchQuoteUseCase = fetchQuoteUseCase
    }
}

// MARK: - Input

extension DoneListViewModel {
    func didTapChartButton() {
        showChartView.send(currentDate)
    }
    
    func didTapSettingButton() {
        showSettingView.send()
    }
    
    func didTapYesterDayButton() {
        guard let dayBefore = currentDate.dayBefore else { return }
        
        currentDate = dayBefore
    }
    
    func didTapTomorrowButton() {
        guard let dayAfter = currentDate.dayAfter else { return }
        
        currentDate = dayAfter
    }
    
    func didTapDateLabel() {
        showCalendarView.send(currentDate)
    }
    
    func didCellSwipe(target item: Done) {
        _ = doneUseCase.deleteItem(target: item)
    }
    
    func didTapCell(with item: Done) {
        showDoneEditView.send(item)
    }
    
    func didTapAddButton() {
        showDoneCreateView.send(currentDate)
    }
    
    func didChangeTargetDate(to date: Date) {
        currentDate = date
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
    
    var startOfDay: Date? {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
    
    var endOfDay: Date? {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)
    }
}
