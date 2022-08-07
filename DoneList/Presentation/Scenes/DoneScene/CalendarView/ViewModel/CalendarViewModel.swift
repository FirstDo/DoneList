//
//  CalendarViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import Combine
import Foundation

protocol CalendarViewModelInput {
    func didTapCell(_ date: Date)
    func willTapCell(_ date: Date) -> Bool
    func didSwipeCalendar(_ date: Date)
}

protocol CalendarViewModelOutput {
    var appFont: AppFont { get }
    var selectedDate: CurrentValueSubject<Date, Never> { get }
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
    var reloadCalendar: PassthroughSubject<Void, Never> { get }
    
    func numberOfEvent(_ date: Date) -> Int
}

protocol CalendarViewModelType: CalendarViewModelInput, CalendarViewModelOutput {}

final class CalendarViewModel: CalendarViewModelType {
    
    private var event: [Date: Bool] = [:]
    private let currentPageDate: CurrentValueSubject<Date, Never>
    private let doneUseCase: DoneUseCaseType
    private let changedTargetDate: (Date) -> ()
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    let appFont: AppFont = FontManager.getFontName()
    let selectedDate: CurrentValueSubject<Date, Never>
    let dismissView = PassthroughSubject<Void, Never>()
    let showErrorAlert = PassthroughSubject<String, Never>()
    let reloadCalendar = PassthroughSubject<Void, Never>()
    
    func numberOfEvent(_ date: Date) -> Int {
        return event[date.startOfDay] == true ? 1 : 0
    }
    
    init(doneUseCase: DoneUseCaseType, date: Date, changedTargetDate: @escaping (Date) -> ()) {
        self.doneUseCase = doneUseCase
        self.changedTargetDate = changedTargetDate
        self.selectedDate = CurrentValueSubject<Date, Never>(date)
        self.currentPageDate = CurrentValueSubject<Date, Never>(date)
        
        currentPageDate.flatMap { date in
            return doneUseCase.fetchItems(from: date.startOfMonth, to: date.endOfMonth)
        }
        .sink { [weak self] items in
            self?.event = items
            self?.reloadCalendar.send()
        }
        .store(in: &cancelBag)
    }
}

// MARK: - Input

extension CalendarViewModel {
    func didTapCell(_ date: Date) {
        changedTargetDate(date)
        dismissView.send()
    }
    
    func willTapCell(_ date: Date) -> Bool {
        guard date < Date.now.dayAfter else {
            showErrorAlert.send("미래의 날짜는 선택할 수 없어요")
            return false
        }
        
        return true
    }
    
    func didSwipeCalendar(_ date: Date) {
        currentPageDate.send(date)
    }
}
