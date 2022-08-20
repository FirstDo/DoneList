//
//  OpenSourceListViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/20.
//

@testable import DoneList
import XCTest

class OpenSourceListViewModelTests: XCTestCase {
    
    var sut: OpenSourceListViewModel!

    override func setUpWithError() throws {
        sut = OpenSourceListViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_navigationTitle이_오픈소스_여야한다() {
        // given
        let expectedValue = "오픈소스"
        
        // when
        
        // then
        XCTAssertEqual(sut.navigationTitle, expectedValue)
    }
    
    func test_openSource에데이터가3개들어있어야한다() {
        // given
        let expectedValue = 3
        
        // when
        
        // then
        XCTAssertEqual(sut.openSources.count, expectedValue)
    }
}
