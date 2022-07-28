//
//  DoneRepositoryType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine

protocol DoneRepositoryType {
    func createItem(_ item: Done)
    var readItems: AnyPublisher<[Done], Never> { get }
    func updateItem(to item: Done)
    func deleteItem(target item: Done)
}
