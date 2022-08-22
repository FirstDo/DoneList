//
//  FetchQueueUseCaseTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/22.
//

@testable import DoneList
import XCTest

class FetchQueueUseCaseTests: XCTestCase {
    
    var sut: FetchQuoteUseCaseType!
    var mockQuotesRepository: MockQuotesRepository!

    override func setUpWithError() throws {
        mockQuotesRepository = MockQuotesRepository()
        sut = FetchQuoteUsecase(repository: mockQuotesRepository)
    }

    override func tearDownWithError() throws {
        mockQuotesRepository = nil
        sut = nil
    }
    
    func test_fetchQuote를호출했을때_repository의fetchQuote이호출되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "fetchQuote이호출되어야한다")
        let expectedValue = Quote(content: "명언입니다", person: "dudu")
        var value: Quote!
        
        // when
        _ = sut.fetchQuote()
            .sink { _ in
                
            } receiveValue: { quote in
                value = quote
                expectation.fulfill()
            }

        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue.content, value.content)
        XCTAssertEqual(expectedValue.person, value.person)
        XCTAssertEqual(mockQuotesRepository.fetchQuoteCallCount, 1)
    }
}
