//
//  DoneUseCase.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol DoneUseCaseType {
    func createNewItem(_ item: Done) -> Completable<StorageError>
    func fetchAllItem() -> AnyPublisher<[Done], Never>
    func editItem(to item: Done) -> Completable<StorageError>
    func deleteItem(target item: Done) -> Completable<StorageError>
}

final class DoneUseCase: DoneUseCaseType {
    
    private let repository: DoneRepositoryType
    
    init(repository: DoneRepositoryType) {
        self.repository = repository
    }
    
    func createNewItem(_ item: Done) -> Completable<StorageError> {
        return repository.createItem(item)
    }
    
    func fetchAllItem() -> AnyPublisher<[Done], Never> {
        return repository.readItems()
    }
    
    func editItem(to item: Done) -> Completable<StorageError> {
        return repository.updateItem(to: item)
    }
    
    func deleteItem(target item: Done) -> Completable<StorageError> {
        return repository.deleteItem(target: item)
    }
}
