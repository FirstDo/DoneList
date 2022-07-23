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
}

protocol CalendarViewModelOutput {
    var selectedDate: CurrentValueSubject<Date, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol CalendarViewModelType: CalendarViewModelInput, CalendarViewModelOutput {}

final class CalendarViewModel: CalendarViewModelType {
    
    private let changedTargetDate: (Date) -> ()
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    let selectedDate: CurrentValueSubject<Date, Never>
    let dismissView = PassthroughSubject<Void, Never>()
    
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
}
