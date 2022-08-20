//
//  CalendarViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList
import XCTest

class CalendarViewModelTests: XCTestCase {
    
    var sut: CalendarViewModelType!
    var mockUseCase: MockDoneUseCase!
    let targetDate = Date.now
    var changedTargetDate: ((Date) -> ())!

    override func setUpWithError() throws {
        changedTargetDate = { date in
            XCTAssertEqual(date, self.targetDate)
        }
        mockUseCase = MockDoneUseCase()
        sut = CalendarViewModel(doneUseCase: mockUseCase, date: targetDate, changedTargetDate: changedTargetDate)
    }

    override func tearDownWithError() throws {
        changedTargetDate = nil
        mockUseCase = nil
        sut = nil
    }
    
    func test_didTapCell을호출했을때_changedTargetDate클로져가실행되어야한다() {
        // given
        
        // when
        sut.didTapCell(targetDate)
        
        // then
    }
    
    func test_didTapCell을호출했을때_dismissView에Void가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "void가 전달되어야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.dismissView
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        sut.didTapCell(targetDate)
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_willTapCell을호출했을때_현재날짜이전이면True를반환해야한다() {
        // given
        let date = Date.now.dayBefore
        let expectedValue = true
        
        // when
        let value = sut.willTapCell(date)
        
        // then
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_willTapCell을호출했을때_현재날짜이후면False를반환해야한다() {
        // given
        let date = Date.now.dayAfter.dayAfter
        let expectedValue = false
        
        // when
        let value = sut.willTapCell(date)
        
        // then
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_willTapCell을호출했을때_현재날짜이후면showErrorAlert에이벤트를보내야한다() {
        // given
        let date = Date.now.dayAfter.dayAfter
        let expectation = XCTestExpectation(description: "이벤트를보내야한다")
        let expectedValue = true
        var value = false
        
        // when
        let cancellable = sut.showErrorAlert
            .sink { _ in
                value = true
                expectation.fulfill()
            }
        _ = sut.willTapCell(date)
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didSwipeCalendar을호출했을때_currentPageDate에Date가전달되어야한다() {
        // empty
    }
    
    func test_selectedDate을호출했을때_전달받은Date를반환해야한다() {
        // given
        
        // when
        
        // then
        XCTAssertEqual(sut.selectedDate.value, targetDate)
    }
}
