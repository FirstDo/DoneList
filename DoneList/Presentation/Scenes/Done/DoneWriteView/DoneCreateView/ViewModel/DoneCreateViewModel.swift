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
    func didTapCell(_ imageName: String)
}

protocol DoneCreateViewModelOutput {
    var doneImageName: PassthroughSubject<String, Never> { get }
    var dismissView: PassthroughSubject<Void, Never> { get }
}

protocol DoneCreateViewModelType: DoneCreateViewModelInput, DoneCreateViewModelOutput {}

final class DoneCreateViewModel: DoneCreateViewModelType {
   
    private let doneUseCase: DoneUseCaseType
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Output
    
    var doneImageName = PassthroughSubject<String, Never>()
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
    
    func didTapCell(_ imageName: String) {
        doneImageName.send(imageName)
    }
}
