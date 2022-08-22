//
//  DoneListViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/22.
//

@testable import DoneList
import XCTest

class DoneListViewModelTests: XCTestCase {
    
    var sut: DoneListViewModelType!
    var mockDoneUseCase: MockDoneUseCase!
    var mockFetchQuoteUseCase: MockFetchQuoteUseCase!
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "YYYY.MM.dd"
        
        return formatter
    }()

    override func setUpWithError() throws {
        mockDoneUseCase = MockDoneUseCase()
        mockFetchQuoteUseCase = MockFetchQuoteUseCase()
        
        sut = DoneListViewModel(doneUseCase: mockDoneUseCase, fetchQuoteUseCase: mockFetchQuoteUseCase)
    }

    override func tearDownWithError() throws {
        mockDoneUseCase = nil
        mockFetchQuoteUseCase = nil
        sut = nil
    }
    
    func test_didTapChartButton을호출했을때_showChartView에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showChartView에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.showChartView
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        sut.didTapChartButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapSettingButton을호출했을때_showSettingView에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showSettingView에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.showSettingView
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        sut.didTapSettingButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapYesterDayButton을호출했을떄_currentDate가전날로변경되어야한다() {
        // empty
    }
    
    func test_didTapTomorrowButton을호출했을때_미래날짜라면showErrorAlert에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showErrorAlert에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        
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
    
    func test_didTapDateLabel을호출했을때_showCalendarView에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showCalendarView에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.showCalendarView.sink { _ in
            value = true
            expectation.fulfill()
        }
        sut.didTapDateLabel()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didCellSwipe을호출했을때_doneUseCae의DeleteItem이호출되어야한다() {
        // given
        let item = Done.testDummy.first!
        
        // when
        sut.didCellSwipe(target: item)
        
        // then
        XCTAssertEqual(mockDoneUseCase.deleteItemCallCount, 1)
    }
    
    func test_didTapCell을호출했을때_showDoneEditView에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showDoneEditView에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        let item = Done.testDummy.first!
        
        // when
        let cancellable = sut.showDoneEditView.sink { _ in
            value = true
            expectation.fulfill()
        }
        sut.didTapCell(with: item)
        
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapAddButton을호출했을때_showDoneCreateView에이벤트가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "showDoneCreateView에이벤트가전달되어야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.showDoneCreateView.sink { _ in
            value = true
            expectation.fulfill()
        }
        sut.didTapAddButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didChangeTargetDate를호출했을때_currentDate가전달받은날짜로변경되어야한다() {
        // empty
    }
    
    func test_doneItems을호출했을때_() {
        // empty
    }
    
    func test_dateTitle을호출했을때_currentDate가Formatter형식으로나와야한다() {
        // empty
    }
    
    func test_quote을호출했을때_Quote가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "Quote가반환되어야한다")
        let expectedValue = Quote(content: "명언입니다", person: "dudu")
        var value: Quote!
        
        // when
        _ = sut.quote
            .sink { quote in
                value = quote
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue.person, value.person)
        XCTAssertEqual(expectedValue.content, value.content)
    }
}
