//
//  QuotesRepositoryTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/22.
//

@testable import DoneList
import XCTest

import Combine

class QuotesRepositoryTests: XCTestCase {
    
    var sut: QuotesRepositoryType!
    var apiProvider: APIProvider!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        setMockRequestHandler()
        apiProvider = APIProvider(urlSession: makeMockURLSession())
        sut = QuotesRepository(apiProvider: apiProvider)
    }

    override func tearDownWithError() throws {
        apiProvider = nil
        sut = nil
    }
    
    func test_fetchQuote를호출했을때_Quote_Never_Publisher가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "Quote_Never_Publisher가반환되어야한다")
        let expectedValue = Quote(content: "명언입니다", person: "dudu")
        var value: Quote!
        
        // when
        sut.fetchQuote()
            .sink { _ in

            } receiveValue: { quote in
                debugPrint(quote)
                value = quote
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue.content, value.content)
        XCTAssertEqual(expectedValue.person, value.person)
    }
    
    private func makeMockURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
    
    private func setMockRequestHandler() {
        let mockQuote = [["result": "success"], ["respond": "명언입니다 - dudu"]]
        let mockData = try! JSONSerialization.data(withJSONObject: mockQuote)
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
    }
}
