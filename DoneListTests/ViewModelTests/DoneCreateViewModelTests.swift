//
//  DoneCreateViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList
import XCTest

class DoneCreateViewModelTests: XCTestCase {
    
    var sut: DoneCreateViewModel!
    var mockUseCase: MockDoneUseCase!
    let targetDate = Date.now

    override func setUpWithError() throws {
        mockUseCase = MockDoneUseCase()
        sut = DoneCreateViewModel(doneUseCase: mockUseCase, date: targetDate)
    }

    override func tearDownWithError() throws {
        mockUseCase = nil
        sut = nil
    }
    
    func test_didTapCreateButton을호출했을때_doneUseCase의CreateNewItem이호출되어야한다() {
        // given
        
        // when
        sut.didTapCreateButton()
        
        // then
        XCTAssertEqual(mockUseCase.createNewItemCallCount, 1)
    }
    
    func test_didTapCreateButton을호출했을때_dismissView에void가전달되어야한다() {
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
        sut.didTapCreateButton()
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedValue, value)
    }
    
    func test_didTapCell을호출했을때_categorySubject에Item이전달되어야한다() {
        // given
        let category = Category(name: "테스트입니다")
        
        // when
        sut.didTapCell(category)
        
        // then
        XCTAssertEqual(sut.category.value, category)
    }
    
    func test_didEditTextField를호출했을때_doneTitle에text가전달되어야한다() {
        // empty
    }
    
    func test_cellItems을호출했을때_모든Category가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "모든Category가반환되어야한다")
        let expectedValue = Category.all
        var value = [Category.empty]
        
        // when
        _ = sut.cellItems
            .sink { categories in
                value = categories
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_doneButtonState을호출했을때_taskTitle과Category가값이없다면False가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "true가 반환되어야 한다")
        let expectedValue = false
        var value = true
        
        // when
        _ = sut.doneButtonState
            .sink { state in
                value = state
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_doneButtonTitle을호출했을때_추가하기_가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "추가하기가반환되어야한다")
        let expectedValue = "추가하기"
        var value = ""
        
        // when
        _ = sut.doneButtonTitle
            .sink { text in
                value = text
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(value, expectedValue)
    }
    
    func test_viewTitle을호출했을때_한_일_추가하기_가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "한 일 추가하기가반환되어야한다")
        let expectedValue = "한 일 추가하기"
        var value = ""
        
        // when
        _ = sut.viewTitle
            .sink { text in
                value = text
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(value, expectedValue)
    }
}
