//
//  DoneEditViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit
import Combine

protocol DoneEditViewModelInput {
    func didTapEditButton()
    func didTapCell(_ item: Category)
    func didEditTextField(_ text: String)
}

protocol DoneEditViewModelOutput {
    var cellItems: AnyPublisher<[Category], Never> { get }
    var taskTitle: CurrentValueSubject<String, Never> { get }
    var category: CurrentValueSubject<Category, Never> { get }
    var doneButtonState: AnyPublisher<Bool, Never> { get }
    var doneButtonTitle: AnyPublisher<String, Never> { get }
    
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol DoneEditViewModelType: DoneEditViewModelInput, DoneEditViewModelOutput {}

final class DonEditViewModel: DoneEditViewModelType {

    private let doneUseCase: DoneUseCaseType
    private let done: Done
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    var cellItems: AnyPublisher<[Category], Never> {
        return Just(Category.all).eraseToAnyPublisher()
    }
    
    var doneButtonState: AnyPublisher<Bool, Never> {
        return taskTitle.combineLatest(category)
            .map { doneTitle, category in
                return !doneTitle.isEmpty && category != .empty
            }
            .eraseToAnyPublisher()
    }
    
    var doneButtonTitle: AnyPublisher<String, Never> {
        return Just("수정하기").eraseToAnyPublisher()
    }
    
    let taskTitle = CurrentValueSubject<String, Never>("")
    let category = CurrentValueSubject<Category, Never>(.empty)
    
    let dismissView = PassthroughSubject<Void, Never>()
    
    init(doneUseCase: DoneUseCaseType, done: Done) {
        self.doneUseCase = doneUseCase
        self.done = done
    }
}

// MARK: - Input

extension DonEditViewModel {

    func didTapCell(_ item: Category) {
        category.send(item)
    }
    
    func didEditTextField(_ text: String) {
        taskTitle.send(text)
    }
    
    func didTapEditButton() {
        let newItem = Done(id: done.id, createdAt: done.createdAt, taskName: taskTitle.value, imageName: category.value.name)
        _ = doneUseCase.editItem(to: newItem)
        dismissView.send()
    }
}

