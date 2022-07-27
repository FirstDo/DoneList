//
//  DoneRepositoryType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol DoneRepositoryType {
    func createItem(_ item: Done) -> Completable<DoneStorageError>
    func readItems() -> AnyPublisher<[Done], Never>
    func updateItem(to item: Done) -> Completable<DoneStorageError>
    func deleteItem(target item: Done) -> Completable<DoneStorageError>
}
