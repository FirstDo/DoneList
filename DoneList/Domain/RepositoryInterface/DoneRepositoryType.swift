//
//  DoneRepositoryType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol DoneRepositoryType {
    func createItem(_ item: Done) -> Completable<StorageError>
    func readItems() -> AnyPublisher<[Done], Never>
    func updateItem(to item: Done) -> Completable<StorageError>
    func deleteItem(target item: Done) -> Completable<StorageError>
}
