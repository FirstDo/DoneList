//
//  DoneStorageType.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import Combine
import Foundation

import RealmSwift

protocol DoneStorageType: AnyObject {
    func create(_ item: Done)
    var read: AnyPublisher<[Done], Never> { get }
    func update(_ item: Done)
    func delete(_ item: Done)
}

final class DoneRealmStorage: DoneStorageType {
    
    private let realm = try? Realm()
    @Published private var items = [Done]()
    
    init() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKey.exsitingUser) {
            updateItem()
        } else {
            UserDefaults.standard.set(true, forKey: UserDefaultsKey.exsitingUser)
            Done.dummy().forEach { create($0) }
        }
    }
    
    func create(_ item: Done) {
        try? realm?.write {
            realm?.add(item.realmDAO())
            items.append(item)
        }
    }
    
    var read: AnyPublisher<[Done], Never> {
        return $items.eraseToAnyPublisher()
    }
    
    func update(_ item: Done) {
        try? realm?.write {
            realm?.add(item.realmDAO(), update: .modified)
            
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index] = item
            }
        }
    }
    
    func delete(_ item: Done) {
        try? realm?.write {
            guard let targetDAO = realm?.object(ofType: DoneDAO.self, forPrimaryKey: item.id) else { return }
            
            realm?.delete(targetDAO)
            items.removeAll { $0.id == item.id }
        }
    }
    
    private func updateItem() {
        guard let realm = realm else { return }
        
        items = realm.objects(DoneDAO.self).map { Done(realmDAO: $0) }
    }
}
