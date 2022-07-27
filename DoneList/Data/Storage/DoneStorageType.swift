//
//  DoneStorageType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine
import Foundation

enum DoneStorageError: LocalizedError {
    case createFail
    case readFail
    case updateFail
    case deleteFail
}

protocol DoneStorageType: AnyObject {
    func create(_ item: Done) -> Completable<DoneStorageError>
    func read() -> AnyPublisher<[Done], Never>
    func update(_ item: Done) -> Completable<DoneStorageError>
    func delete(_ item: Done) -> Completable<DoneStorageError>
}

final class DoneMemoryStorage: DoneStorageType {
    
    @Published private var items = [Done]()
    
    #if DEBUG
    init() {
        items.append(contentsOf: Done.dummy())
    }
    #endif
    
    func create(_ item: Done) -> Completable<DoneStorageError> {
        items.append(item)
        
        return Empty().eraseToAnyPublisher()
    }
    
    func read() -> AnyPublisher<[Done], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: Done) -> Completable<DoneStorageError> {
        if let index = items.firstIndex(where: {$0.id == item.id }) {
            items[index] = item
        }
        
        return Empty().eraseToAnyPublisher()
    }
    
    func delete(_ item: Done) -> Completable<DoneStorageError> {
        items.removeAll { $0.id == item.id }
        
        return Empty().eraseToAnyPublisher()
    }
}
