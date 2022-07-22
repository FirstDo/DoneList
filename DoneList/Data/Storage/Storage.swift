//
//  Storage.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol Storage {
    func create(_ item: Done)
    func read() -> AnyPublisher<[Done], Never>
    func update(_ item: Done)
    func delete(_ item: Done)
}

final class MemoryStorage: Storage {
    @Published private var items = [Done]()
    
    func create(_ item: Done) {
        items.append(item)
    }
    
    func read() -> AnyPublisher<[Done], Never> {
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
