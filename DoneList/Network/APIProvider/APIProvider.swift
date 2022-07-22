//
//  APIProvider.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

final class APIProvider {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request(_ api: EndPoint) -> AnyPublisher<Data, URLError> {
        guard let urlRequest = api.makeURLRequest() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
