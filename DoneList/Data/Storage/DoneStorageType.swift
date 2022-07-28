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
    func create(_ item: Done)
    var read: AnyPublisher<[Done], Never> { get }
    func update(_ item: Done)
    func delete(_ item: Done)
}

final class DoneMemoryStorage: DoneStorageType {
    
    @Published private var items = [Done]()
    
#if DEBUG
    init() {
        items.append(contentsOf: Done.dummy())
    }
#endif
    
    func create(_ item: Done) {
        items.append(item)
    }
    
    var read: AnyPublisher<[Done], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: Done) {
        if let index = items.firstIndex(where: {$0.id == item.id }) {
            items[index] = item
        }
    }
    
    func delete(_ item: Done) {
        items.removeAll { $0.id == item.id }
    }
}
