//
//  UserDefaults+.swift
//  DoneList
//
//  Created by dudu on 2022/08/10.
//

import Foundation

enum UserDefaultsKey {
    static let userFont = "userFont"
}

extension UserDefaults {
    @objc dynamic var font: String {
        return string(forKey: UserDefaultsKey.userFont) ?? AppFont.system.rawValue
    }
}
