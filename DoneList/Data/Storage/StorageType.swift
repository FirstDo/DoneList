//
//  StorageType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine
import Foundation

enum StorageError: LocalizedError {
    case createFail
    case readFail
    case updateFail
    case deleteFail
}

protocol StorageType: AnyObject {
    func create(_ item: Done) -> Completable<StorageError>
    func read() -> AnyPublisher<[Done], Never>
    func update(_ item: Done) -> Completable<StorageError>
    func delete(_ item: Done) -> Completable<StorageError>
}

final class MemoryStorage: StorageType {
    
    @Published private var items = [Done]()
    
    #if DEBUG
    init() {
        items.append(contentsOf: Done.dummy())
    }
    #endif
    
    func create(_ item: Done) -> Completable<StorageError> {
        items.append(item)
        
        return Empty().eraseToAnyPublisher()
    }
    
    func read() -> AnyPublisher<[Done], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: Done) -> Completable<StorageError> {
        if let index = items.firstIndex(where: {$0.id == item.id }) {
            items[index] = item
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    func delete(_ item: Done) -> Completable<StorageError> {
        items.removeAll { $0.id == item.id }
        
        return Empty().eraseToAnyPublisher()
    }
}
