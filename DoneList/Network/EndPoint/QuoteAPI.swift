//
//  QuoteAPI.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

struct QuoteAPI: EndPoint {
    let baseURL: String = "https://api.qwer.pw/"
    let path: String = "request/helpful_text"
    let httpMethod: HttpMethod = .get
    let queryParameters: [String : String]? = ["apikey": "guest"]
    let bodyParameters: Encodable? = nil
    let headers: [String : String]? = nil
}
