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
    func didTapChartButton() {}
    func didTapSettingButton() {}
    func didTapYesterDayButton() {}
    func didTapTomorrowButton() {}
    func didTapDateLabel() {}
    func didTapCell() {}
    func didTapAddButton() {}
}
