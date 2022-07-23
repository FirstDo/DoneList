//
//  QuotesRepository.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

final class QuotesRepository: QuotesRepositoryType {
    
    private unowned let apiProvider: APIProvider
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchQuote() -> AnyPublisher<Quote, Error> {
        let quoteAPI = QuoteAPI()
        
        return apiProvider.request(quoteAPI)
            .share()
            .tryCompactMap { data in
                try JSONSerialization.jsonObject(with: data) as? [[String: String]]
            }
            .compactMap { $0.last?["respond"]?.components(separatedBy: ["-", "–"]) }
            .map { $0.map { $0.trimmingCharacters(in: .whitespaces) } }
            .map { contents in
                return Quote(content: contents[0], person: contents[1])
            }
            .eraseToAnyPublisher()
    }
}
