//
//  DoneUseCase.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Foundation
import Combine

protocol DoneUseCaseType {
    func createNewItem(_ item: Done)
    var fetchAllItem: AnyPublisher<[Done], Never> { get }
    func fetchItems(from startDate: Date, to endDate: Date) -> AnyPublisher<[Date: Bool], Never>
    func fetchItmes(for weeks: [Date]) -> AnyPublisher<[Date: [Done]], Never>
    func editItem(to item: Done)
    func deleteItem(target item: Done)
}

final class DoneUseCase: DoneUseCaseType {
    private let repository: DoneRepositoryType
    
    init(repository: DoneRepositoryType) {
        self.repository = repository
    }
    
    func createNewItem(_ item: Done) {
        return repository.createItem(item)
    }
    
    var fetchAllItem: AnyPublisher<[Done], Never> {
        return repository.readItems
    }
    
    func fetchItems(from startDate: Date, to endDate: Date) -> AnyPublisher<[Date: Bool], Never> {
        return repository.readItems
            .map { items in
                return items.filter { (startDate...endDate) ~= $0.createdAt }
            }
            .map { items in
                var dicts = [Date: Bool]()
                
                items.forEach { item in
                    dicts[item.createdAt.startOfDay] = true
                }
                
                return dicts
            }
            .eraseToAnyPublisher()
    }
    
    func fetchItmes(for weeks: [Date]) -> AnyPublisher<[Date: [Done]], Never> {
        return repository.readItems
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
    
    func editItem(to item: Done) {
        return repository.updateItem(to: item)
    }
    
    func deleteItem(target item: Done) {
        return repository.deleteItem(target: item)
    }
}
