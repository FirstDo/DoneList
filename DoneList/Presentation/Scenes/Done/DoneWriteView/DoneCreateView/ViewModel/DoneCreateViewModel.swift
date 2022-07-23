//
//  DoneCreateViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit
import Combine

protocol DoneCreateViewModelInput {
    func didTapCreateButton()
    func didTapCell(_ item: Category)
    func didEditTextField(_ text: String)
}

protocol DoneCreateViewModelOutput {
    var cellItems: AnyPublisher<[Category], Never> { get }
    var category: CurrentValueSubject<Category, Never> { get }
    var doneButtonState: AnyPublisher<Bool, Never> { get }
    var doneButtonTitle: AnyPublisher<String, Never> { get }
    
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol DoneCreateViewModelType: DoneCreateViewModelInput, DoneCreateViewModelOutput {}

final class DoneCreateViewModel: DoneCreateViewModelType {

    private let doneUseCase: DoneUseCaseType
    private let targetDate: Date
    private var cancelBag = Set<AnyCancellable>()
    
    @Published var doneTitle: String = ""
    
    // MARK: - Output
    
    var cellItems: AnyPublisher<[Category], Never> {
        return Just(Category.all).eraseToAnyPublisher()
    }
    
    var doneButtonState: AnyPublisher<Bool, Never> {
        return $doneTitle.combineLatest(category)
            .map { doneTitle, category in
                return !doneTitle.isEmpty && category != .empty
            }
            .eraseToAnyPublisher()
    }
    
    var doneButtonTitle: AnyPublisher<String, Never> {
        return Just("만들기").eraseToAnyPublisher()
    }
    
    let category = CurrentValueSubject<Category, Never>(.empty)
    let dismissView = PassthroughSubject<Void, Never>()
    
    init(doneUseCase: DoneUseCaseType, date: Date) {
        self.doneUseCase = doneUseCase
        self.targetDate = date
    }
}

// MARK: - Input

extension DoneCreateViewModel {

    func didTapCell(_ item: Category) {
        category.send(item)
    }
    
    func didEditTextField(_ text: String) {
        doneTitle = text
    }
    
    func didTapCreateButton() {
        _ = doneUseCase.createNewItem(Done(createdAt: targetDate, taskName: doneTitle, category: category.value))
        dismissView.send()
    }
}
