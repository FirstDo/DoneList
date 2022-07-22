//
//  Repository.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

final class DefaultQuotesRepository: QuotesRepository {
    
    private let apiProvider: APIProvider
    
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
            .compactMap { $0.last?["respond"] }
            .map { Quote(quote: $0) }
            .eraseToAnyPublisher()
    }
}
