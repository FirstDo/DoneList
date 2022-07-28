//
//  DoneRepository.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

final class DoneRepository: DoneRepositoryType {
    
    private unowned let storage: DoneStorageType
    
    init(storage: DoneStorageType) {
        self.storage = storage
    }
    
    func createItem(_ item: Done) {
        storage.create(item)
    }
    
    var readItems: AnyPublisher<[Done], Never> {
        return storage.read
    }
    
    func updateItem(to item: Done) {
        storage.update(item)
    }
    
    func deleteItem(target item: Done) {
        storage.delete(item)
    }
}
