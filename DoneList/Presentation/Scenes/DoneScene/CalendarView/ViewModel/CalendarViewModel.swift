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
}

protocol CalendarViewModelOutput {
    var selectedDate: CurrentValueSubject<Date, Never> { get }
    var showErrorAlert: PassthroughSubject<String, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
    
    func numberOfEvent(_ date: Date) -> Int
}

protocol CalendarViewModelType: CalendarViewModelInput, CalendarViewModelOutput {}

final class CalendarViewModel: CalendarViewModelType {
    
    private let changedTargetDate: (Date) -> ()
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    let selectedDate: CurrentValueSubject<Date, Never>
    let dismissView = PassthroughSubject<Void, Never>()
    let showErrorAlert = PassthroughSubject<String, Never>()
    
    func numberOfEvent(_ date: Date) -> Int {
        return 1
    }
    
    init(date: Date, changedTargetDate: @escaping (Date) -> ()) {
        self.changedTargetDate = changedTargetDate
        self.selectedDate = CurrentValueSubject<Date, Never>(date)
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
}
