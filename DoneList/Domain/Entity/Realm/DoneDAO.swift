//
//  DoneDAO.swift
//  DoneList
//
//  Created by dudu on 2022/08/11.
//

import Foundation

import RealmSwift

final class DoneDAO: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var createdAt: Date
    @Persisted var taskName: String
    @Persisted var categoryName: String
}
