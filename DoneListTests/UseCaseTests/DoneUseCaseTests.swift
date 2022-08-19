//
//  DoneUseCaseTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/18.
//

import XCTest
@testable import DoneList

import Combine

class DoneUseCaseTests: XCTestCase {
    var sut: DoneUseCase!
    var mockDoneRepository: MockDoneRepository!

    override func setUpWithError() throws {
        mockDoneRepository = MockDoneRepository()
        sut = DoneUseCase(repository: mockDoneRepository)
    }

    override func tearDownWithError() throws {
        mockDoneRepository = nil
        sut = nil
    }
    
    func test_createNewItem을호출했을때_repository의createItem이호출되어야한다() {
        // given
        let item = Done(createdAt: .now, taskName: "테스트작업", category: .empty)
        
        // when
        sut.createNewItem(item)
        
        // then
        XCTAssertEqual(item, mockDoneRepository.item)
        XCTAssertEqual(1, mockDoneRepository.createItemCallCount)
    }
    
    func test_fetchAllItem을호출했을때_모든Item이반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "모든 아이템이 반환되는지")
        let expectedItemCount = 100
        var itemCount = 0
        
        // when
        _ = sut.fetchAllItem
            .sink { dones in
                itemCount = dones.count
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(itemCount, expectedItemCount)
    }
    
    func test_fetchItems_from_to을호출했을때_범위내의Date_Bool딕셔너리가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "딕셔너리의 value가 모두 true인지")
        let start = Date.now.startOfDay.dayAfter
        let end = start.addingTimeInterval(86400 * 19)
        let expectedItemCount = 20
        var itemCount = 0
        
        // when
        _ = sut.fetchItems(from: start, to: end)
            .sink { dicts in
                itemCount = dicts.values.filter { $0 }.count
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(itemCount, expectedItemCount)
    }
    
    func test_fetchItems_for을호출했을때_범위내의Date_Dones딕셔너리가반환되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "반환되는 Dones가 7개인지")
        let week = Date.now.startOfDay.addingTimeInterval(86400 * 8).findWeeks
        let expectedItemCount = 7
        var itemCount = 0
        
        // when
        _ = sut.fetchItmes(for: week)
            .sink { dicts in
                itemCount = dicts.values.reduce(0, { partialResult, items in
                    partialResult + items.count
                })
                print(itemCount)
                expectation.fulfill()
            }
        
        // then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(itemCount, expectedItemCount)
    }
    
    func test_editItem을호출했을때_repository의updateItem이호출되어야한다() {
        // given
        let item = Done(createdAt: .now, taskName: "테스트작업", category: .empty)
        
        // when
        sut.editItem(to: item)
        
        // then
        XCTAssertEqual(item, mockDoneRepository.item)
        XCTAssertEqual(1, mockDoneRepository.updateItemCallCount)
    }
    
    func test_deleteItem을호출했을때_repository의deleteItem이호출되어야한다() {
        // given
        let item = Done(createdAt: .now, taskName: "테스트작업", category: .empty)
        
        // when
        sut.deleteItem(target: item)
        
        // then
        XCTAssertEqual(item, mockDoneRepository.item)
        XCTAssertEqual(1, mockDoneRepository.deleteItemCallCount)
    }
}
