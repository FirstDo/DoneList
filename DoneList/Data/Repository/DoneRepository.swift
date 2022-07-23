//
//  DoneRepository.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

final class DoneRepository: DoneRepositoryType {
    
    private unowned let storage: StorageType
    
    init(storage: StorageType) {
        self.storage = storage
    }
    
    func createItem(_ item: Done) -> Completable<StorageError> {
        return storage.create(item)
    }
    
    func readItems() -> AnyPublisher<[Done], Never> {
        return storage.read()
    }
    
    func updateItem(to item: Done) -> Completable<StorageError> {
        return storage.update(item)
    }
    
    func deleteItem(target item: Done) -> Completable<StorageError> {
        return storage.delete(item)
    }
}
