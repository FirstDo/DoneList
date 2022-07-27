//
//  DoneUseCase.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

protocol DoneUseCaseType {
    func createNewItem(_ item: Done) -> Completable<DoneStorageError>
    func fetchAllItem() -> AnyPublisher<[Done], Never>
    func fetchItmes(for weeks: [Date]) -> AnyPublisher<[Date: [Done]], Never>
    func editItem(to item: Done) -> Completable<DoneStorageError>
    func deleteItem(target item: Done) -> Completable<DoneStorageError>
}

final class DoneUseCase: DoneUseCaseType {
    
    private let repository: DoneRepositoryType
    
    init(repository: DoneRepositoryType) {
        self.repository = repository
    }
    
    func createNewItem(_ item: Done) -> Completable<DoneStorageError> {
        return repository.createItem(item)
    }
    
    func fetchAllItem() -> AnyPublisher<[Done], Never> {
        return repository.readItems()
    }
    
    func fetchItmes(for weeks: [Date]) -> AnyPublisher<[Date: [Done]], Never> {
        return repository.readItems()
            .map { items in
                return items.filter { (weeks.first!...weeks.last!) ~= $0.createdAt }
            }
            .map { items in
                var dicts = [Date: [Done]]()
                weeks.forEach { dicts[$0] = [] }
                
                items.forEach { item in
                    dicts[item.createdAt]?.append(item)
                }
                
                return dicts
            }
            
            .eraseToAnyPublisher()
    }
    
    func editItem(to item: Done) -> Completable<DoneStorageError> {
        return repository.updateItem(to: item)
    }
    
    func deleteItem(target item: Done) -> Completable<DoneStorageError> {
        return repository.deleteItem(target: item)
    }
}
