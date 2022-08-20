//
//  DoneChartViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList
import XCTest

class DoneChartViewModelTests: XCTestCase {
    
    var sut: DoneChartViewModelType!
    var mockUsecase: MockDoneUseCase!
    var targetDate = Date.now
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "M.d"
        
        return formatter
    }()

    override func setUpWithError() throws {
        mockUsecase = MockDoneUseCase()
        sut = DoneChartViewModel(doneUseCase: mockUsecase, targetDate: targetDate)
    }

    override func tearDownWithError() throws {
        mockUsecase = nil
        sut = nil
    }
    
    func test_didTapYesterDayButton을호출했을때_targetDate가일주일전으로바뀌여야한다() {
        // empty
    }
    
    func test_didTapTomorrowButton을호출했을때_미래의날짜라면ShowErrorAlert에이벤트를보내야한다() {
        // given
        let expectation = XCTestExpectation(description: "showErrorAlert에 이벤트를 보내야한다")
        let expectedValue = true
        var value = false
        self.targetDate = targetDate.findWeeks.last!.dayAfter
        
        // when
        let cancellable = sut.showErrorAlert
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        sut.didTapTomorrowButton()
        
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapTomorrowButton을호출했을때_미래의날짜가아니라면ShowErrorAlert에이벤트를보내지말아야한다() {
        // given
        let expectation = XCTestExpectation(description: "ShowErrorAlert에이벤트를보내지말아야한다")
        let expectedValue = false
        var value = true
        self.targetDate = targetDate.findWeeks.first!.dayBefore
        
        // when
        let cancellable = sut.showErrorAlert
            .sink { _ in
                value = false
                expectation.fulfill()
            }
        sut.didTapTomorrowButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapCloseButton을호출했을때_dismissView에이벤트를보내야한다() {
        // given
        let expectation = XCTestExpectation(description: "dismissView에이벤트를보내야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.dismissView
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        sut.didTapCloseButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_dateTitle을호출했을때_일주일형식의string이반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "일주일형식의string이반환되어야한다")
        let expectedValue = self.dateFormatter.string(from: targetDate.findWeeks.first!) + " ~ " + self.dateFormatter.string(from: targetDate.findWeeks.last!)
        var value = ""
        
        // when
        _ = sut.dateTitle
            .sink { formattedString in
                value = formattedString
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_weekIndexTitle을호출했을때_일주일날짜가담겨있는string배열이반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "일주일날짜가담겨있는string배열이반환되어야한다")
        let expectedValue = targetDate.findWeeks.map { self.dateFormatter.string(from: $0)}
        var value = [String]()
        
        // when
        _ = sut.weekIndexTitle
            .sink { strings in
                value = strings
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_graphValues를호출했을때_tastCount_totalTaskCount튜플배열이반환되어야한다() {
        // empty
    }
}
