//
//  DoneCreateViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import Foundation
import Combine

protocol DoneCreateViewModelInput {
    func didTapCreateButton(_ imageName: String?, _ taskName: String?)
    func didTapCell(_ item: Category)
}

protocol DoneCreateViewModelOutput {
    var cellItems: AnyPublisher<[Category], Never> { get }
    var doneImageName: PassthroughSubject<Category, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol DoneCreateViewModelType: DoneCreateViewModelInput, DoneCreateViewModelOutput {}

final class DoneCreateViewModel: DoneCreateViewModelType {
   
    private let doneUseCase: DoneUseCaseType
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    var cellItems: AnyPublisher<[Category], Never> {
        return Just(Category.all).eraseToAnyPublisher()
    }
    let doneImageName = PassthroughSubject<Category, Never>()
    let dismissView = PassthroughSubject<Void, Never>()
    
    init(doneUseCase: DoneUseCaseType) {
        self.doneUseCase = doneUseCase
    }
}

// MARK: - Input

extension DoneCreateViewModel {
    func didTapCreateButton(_ imageName: String?, _ taskName: String?) {
        guard let imageName = imageName, let taskName = taskName else { return }
        
        _ = doneUseCase.createNewItem(Done(createdAt: Date.now, taskName: taskName, imageName: imageName))
        dismissView.send()
    }
    
    func didTapCell(_ item: Category) {
        doneImageName.send(item)
    }
}
