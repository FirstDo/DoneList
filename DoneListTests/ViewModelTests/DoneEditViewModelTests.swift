//
//  DoneEditViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList
import XCTest

import Combine

class DoneEditViewModelTests: XCTestCase {
    
    var sut: DoneEditViewModel!
    var mockDoneUseCase: MockDoneUseCase!
    let done = Done(createdAt: .now, taskName: "초기값", category: Category(name: "초기카테고리"))

    override func setUpWithError() throws {
        mockDoneUseCase = MockDoneUseCase()
        sut = DoneEditViewModel(doneUseCase: mockDoneUseCase, done: done)
    }

    override func tearDownWithError() throws {
        mockDoneUseCase = nil
        sut = nil
    }
    
    func test_didTapEditButton을호출했을때_usecase의editItem이호출되어야한다() {
        // given
        let expectedItem = Done(id: done.id, createdAt: done.createdAt, taskName: sut.taskTitle.value, category: sut.category.value)
        
        // when
        sut.didTapEditButton()
        
        // then
        XCTAssertEqual(1, mockDoneUseCase.editItemCallCount)
        XCTAssertEqual(expectedItem, mockDoneUseCase.item)
    }
    
    func test_didTapEditButton을호출했을때_dismissView에Void가전달되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "dismissView에Void가전달되어야한다")
        var receiveEvent = false
        
        // when
        let cancellable = sut.dismissView
            .print()
            .sink { empty in
                receiveEvent = true
                expectation.fulfill()
            }
        sut.didTapEditButton()
        
        // then
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(receiveEvent, true)
    }
    
    func test_didTapCell을호출했을때_categorySubject에Item이전달되어야한다() {
        // given
        let category = Category(name: "테스트입니다")
        
        // when
        sut.didTapCell(category)
        
        // then
        XCTAssertEqual(sut.category.value, category)
        
    }
    
    func test_didEditTextField를호출했을때_taskTitle에Text가전달되어야한다() {
        // given
        let text = "테스트입니다"
        
        // when
        sut.didEditTextField(text)
        
        // then
        XCTAssertEqual(sut.taskTitle.value, text)
    }
    
    func test_cellItems을호출했을때_모든Category가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "모든Category가반환되어야한다")
        let expectedItems = Category.all
        var items = [Category.empty]
        
        // when
        _ = sut.cellItems
            .sink { categories in
                items = categories
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(expectedItems, items)
    }
    
    func test_doneButtonState을호출했을때_taskTitle과Category가값이있을때만True가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "true가 반환되어야 한다")
        let expectedValue = true
        var value = false
        
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
    
    func test_doneButtonTitle을호출했을때_수정하기_가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "수정하기가반환되어야한다")
        let expectedTitle = "수정하기"
        var title = ""
        
        // when
        _ = sut.doneButtonTitle
            .sink { text in
                title = text
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(title, expectedTitle)
    }
    
    func test_viewTitle을호출했을때_한_일_수정하기_가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "한 일 수정하기가반환되어야한다")
        let expectedTitle = "한 일 수정하기"
        var title = ""
        
        // when
        _ = sut.viewTitle
            .sink { text in
                title = text
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(title, expectedTitle)
    }
}
