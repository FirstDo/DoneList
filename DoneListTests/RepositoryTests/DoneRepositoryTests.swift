//
//  DoneRepositoryTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/20.
//

@testable import DoneList
import XCTest

class DoneRepositoryTests: XCTestCase {
    
    var sut: DoneRepositoryType!
    var mockStorage: MockDoneStroage!

    override func setUpWithError() throws {
        mockStorage = MockDoneStroage()
        sut = DoneRepository(storage: mockStorage)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockStorage = nil
    }
    
    func test_createItem을호출했을때_storage의createItem이호출되어야한다() {
        // given
        let item = Done.testDummy.first!
        
        // when
        sut.createItem(item)
        
        // then
        XCTAssertEqual(mockStorage.createCallCount, 1)
        XCTAssertEqual(mockStorage.item, item)
    }
    
    func test_updateItem을호출했을때_storage의updateItem이호출되어야한다() {
        // given
        let item = Done.testDummy.first!
        
        // when
        sut.updateItem(to: item)
        
        // then
        XCTAssertEqual(mockStorage.updateCallCount, 1)
        XCTAssertEqual(mockStorage.item, item)
    }
    
    func test_deleteItem을호출했을때_storage의deleteItem이호출되어야한다() {
        // given
        let item = Done.testDummy.first!
        
        // when
        sut.deleteItem(target: item)
        
        // then
        XCTAssertEqual(mockStorage.deleteCallCount, 1)
        XCTAssertEqual(mockStorage.item, item)
    }
}
