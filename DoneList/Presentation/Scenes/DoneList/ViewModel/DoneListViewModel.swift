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
    func didTapCell()
    func didTapAddButton()
}

protocol DoneListViewModelOutput {
    var doneItems: AnyPublisher<[Done], Never> { get }
    var quote: AnyPublisher<Quote, Never> { get }
    var currentDate: CurrentValueSubject<Date, Never> { get }
    
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var showChartView: PassthroughSubject<String, Never> { get }
    var showSettingView: PassthroughSubject<String, Never> { get }
    var showCalendarView: PassthroughSubject<String, Never> { get }
    var showDoneEditView: PassthroughSubject<String, Never> { get }
    var showDoneCreateView: PassthroughSubject<String, Never> { get }
}

protocol DoneListViewModelType: DoneListViewModelInput, DoneListViewModelOutput {}

final class DoneListViewModel:  DoneListViewModelType {
    private let doneUseCase: DoneUseCaseType
    private let fetchQuoteUseCase: FetchQuoteUseCaseType
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - OutPut
    
    var doneItems: AnyPublisher<[Done], Never> {
        return doneUseCase.fetchAllItem()
    }
    
    var quote: AnyPublisher<Quote, Never> {
        return fetchQuoteUseCase
            .fetchQuote()
            .replaceError(with: Quote(quote: "인터넷에 연결해주세요 :("))
            .eraseToAnyPublisher()
    }
    
    let currentDate = CurrentValueSubject<Date, Never>(Date.now)
    
    let showErrorAlert = PassthroughSubject<String, Never>()
    let showChartView = PassthroughSubject<String, Never>()
    let showSettingView = PassthroughSubject<String, Never>()
    let showCalendarView = PassthroughSubject<String, Never>()
    let showDoneEditView = PassthroughSubject<String, Never>()
    let showDoneCreateView = PassthroughSubject<String, Never>()
    
    init(doneUseCase: DoneUseCaseType, fetchQuoteUseCase: FetchQuoteUseCaseType) {
        self.doneUseCase = doneUseCase
        self.fetchQuoteUseCase = fetchQuoteUseCase
    }
}

// MARK: - Input

extension DoneListViewModel {
    func didTapChartButton() {}
    func didTapSettingButton() {}
    func didTapYesterDayButton() {}
    func didTapTomorrowButton() {}
    func didTapDateLabel() {}
    func didTapCell() {}
    func didTapAddButton() {}
}
