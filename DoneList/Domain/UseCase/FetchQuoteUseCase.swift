//
//  FetchQuoteUseCase.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

protocol FetchQuoteUseCaseType {
    func fetchQuote() -> AnyPublisher<Quote, Error>
}

final class FetchQuoteUsecase: FetchQuoteUseCaseType {
    
    private let repository: QuotesRepository
    
    init(repository: QuotesRepository) {
        self.repository = repository
    }
    
    func fetchQuote() -> AnyPublisher<Quote, Error> {
        return repository.fetchQuote()
    }
}
