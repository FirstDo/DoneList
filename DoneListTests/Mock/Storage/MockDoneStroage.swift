//
//  MockDoneStroage.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/20.
//

@testable import DoneList

import Combine

final class MockDoneStroage: DoneStorageType {
    var createCallCount = 0
    var updateCallCount = 0
    var deleteCallCount = 0
    
    var item: Done?
    
    func create(_ item: Done) {
        createCallCount += 1
        self.item = item
    }
    
    var read: AnyPublisher<[Done], Never> {
        return Just([]).eraseToAnyPublisher()
    }
    
    func update(_ item: Done) {
        updateCallCount += 1
        self.item = item
    }
    
    func delete(_ item: Done) {
        deleteCallCount += 1
        self.item = item
    }
}
