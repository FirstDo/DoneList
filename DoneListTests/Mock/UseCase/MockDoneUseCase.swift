//
//  MockDoneUseCase.swift
//  DoneListTests
//
//  Created by dudu on 2022/08/19.
//

@testable import DoneList

import Foundation
import Combine

final class MockDoneUseCase: DoneUseCaseType {
    var createNewItemCallCount = 0
    var editItemCallCount = 0
    var deleteItemCallCount = 0
    
    var item: Done?
    
    func createNewItem(_ item: Done) {
        createNewItemCallCount += 1
        self.item = item
    }
    
    var fetchAllItem: AnyPublisher<[Done], Never> {
        return Just([]).eraseToAnyPublisher()
    }
    
    func fetchItems(from startDate: Date, to endDate: Date) -> AnyPublisher<[Date : Bool], Never> {
        return Just([:]).eraseToAnyPublisher()
    }
    
    func fetchItmes(for weeks: [Date]) -> AnyPublisher<[Date : [Done]], Never> {
        return Just([:]).eraseToAnyPublisher()
    }
    
    func editItem(to item: Done) {
        editItemCallCount += 1
        self.item = item
    }
    
    func deleteItem(target item: Done) {
        deleteItemCallCount += 1
        self.item = item
    }
}
