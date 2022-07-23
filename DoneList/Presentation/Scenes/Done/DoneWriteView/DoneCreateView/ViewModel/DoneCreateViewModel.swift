//
//  DoneCreateViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import Foundation
import Combine

protocol DoneCreateViewModelInput {
    func didTapCreateButton()
    func didTapCell(_ item: Category)
    func didEditTextField(_ text: String)
}

protocol DoneCreateViewModelOutput {
    var cellItems: AnyPublisher<[Category], Never> { get }
    var category: CurrentValueSubject<Category, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
    var doneButtonState: AnyPublisher<Bool, Never> { get }
}

protocol DoneCreateViewModelType: DoneCreateViewModelInput, DoneCreateViewModelOutput {}

final class DoneCreateViewModel: DoneCreateViewModelType {

    private let doneUseCase: DoneUseCaseType
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
    
    let category = CurrentValueSubject<Category, Never>(.empty)
    let dismissView = PassthroughSubject<Void, Never>()
    
    init(doneUseCase: DoneUseCaseType) {
        self.doneUseCase = doneUseCase
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
        print(#function)
        doneUseCase.createNewItem(Done(createdAt: Date.now, taskName: doneTitle, imageName: category.value.name))
        dismissView.send()
    }
}
