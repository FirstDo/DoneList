//
//  SettingViewModelTests.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/20.
//

@testable import DoneList
import XCTest

class SettingViewModelTests: XCTestCase {
    
    var sut: SettingViewModel!

    override func setUpWithError() throws {
        sut = SettingViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_navigationTitle이_설정_이여야한다() {
        // given
        let expectedValue = "설정"
        
        // when
        
        // then
        XCTAssertEqual(sut.navigationTitle, expectedValue)
    }
    
    func test_appSettingSectionHeader가_앱_설정_이여야한다() {
        // given
        let expectedValue = "앱 설정"
        
        // when
        
        // then
        XCTAssertEqual(sut.appSettingSectionHeader, expectedValue)
    }
    
    func test_otherSettingSectionHeader가_기타_여야한다() {
        // given
        let expectedValue = "기타"
        
        // when
        
        // then
        XCTAssertEqual(sut.otherSettingSectionHeader, expectedValue)
    }
    
    func test_otherSettingSectionFooter가_developed_by_dudu_여야한다() {
        // given
        let expectedValue = "developed by dudu"
        
        // when
        
        // then
        XCTAssertEqual(sut.otherSettingSectionFooter, expectedValue)
    }
}
