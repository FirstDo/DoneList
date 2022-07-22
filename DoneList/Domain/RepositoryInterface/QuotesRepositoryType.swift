//
//  QuoteRepository.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol QuotesRepositoryType {
    func fetchQuote() -> AnyPublisher<Quote, Error>
}
