//
//  EndPoint.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var queryParameters: [String: String]? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
}

extension EndPoint {
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURLwithQuery() else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = bodyParameters?.makeData()
        
        if let headers = headers {
            headers.forEach { key, value in
                urlRequest.addValue(key, forHTTPHeaderField: value)
            }
        }
        
        return urlRequest
    }
    
    private func makeURLwithQuery() -> URL? {
        var urlComponents = URLComponents(string: baseURL + path)
        
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { key, value in
                return URLQueryItem(name: key, value: value)
            }
        }
        
        return urlComponents?.url
    }
}

fileprivate extension Encodable {
    
    func makeData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
