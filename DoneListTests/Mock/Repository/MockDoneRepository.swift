//
//  MockDoneRepository.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/18.
//

@testable import DoneList

import Combine

final class MockDoneRepository: DoneRepositoryType {
    var createItemCallCount = 0
    var updateItemCallCount = 0
    var deleteItemCallCount = 0
    var item: Done?
    
    @Published var items: [Done]
    
    init() {
        items = Done.testDummy
    }
    
    func createItem(_ item: Done) {
        createItemCallCount += 1
        self.item = item
    }
    
    var readItems: AnyPublisher<[Done], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func updateItem(to item: Done) {
        updateItemCallCount += 1
        self.item = item
    }
    
    func deleteItem(target item: Done) {
        deleteItemCallCount += 1
        self.item = item
    }
}



