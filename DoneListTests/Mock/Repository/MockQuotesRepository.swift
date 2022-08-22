//
//  MockQuotesRepository.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/22.
//

@testable import DoneList
import Combine

final class MockQuotesRepository: QuotesRepositoryType {
    var fetchQuoteCallCount = 0
    
    func fetchQuote() -> AnyPublisher<Quote, Error> {
        let dummyQuote = Quote(content: "명언입니다", person: "dudu")
        
        fetchQuoteCallCount += 1
        
        return Just(dummyQuote)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
