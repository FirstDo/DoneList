//
//  DoneListViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

protocol DoneListViewModelInput {
    
}

protocol DoneListViewModelOutput {
    
}

protocol DoneListViewModelType: DoneListViewModelInput, DoneListViewModelOutput {}

final class DoneListViewModel:  DoneListViewModelType {
    private let doneUseCase: DoneUseCaseType
    private let fetchQuoteUseCase: FetchQuoteUseCaseType
    
    private var cancelBag = Set<AnyCancellable>()
    
    init(doneUseCase: DoneUseCaseType, fetchQuoteUseCase: FetchQuoteUseCaseType) {
        self.doneUseCase = doneUseCase
        self.fetchQuoteUseCase = fetchQuoteUseCase
    }
}
