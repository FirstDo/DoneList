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
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol CalendarViewModelType: CalendarViewModelInput, CalendarViewModelOutput {}

final class CalendarViewModel: CalendarViewModelType {
    private let date: Date
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    let dismissView = PassthroughSubject<Void, Never>()
    
    init(date: Date) {
        self.date = date
    }
}

// MARK: - Input

extension CalendarViewModel {
    func didTapCell(_ date: Date) {
        
    }
}
