//
//  Setting.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import Foundation

enum Section {
    case appSetting
    case other
}

enum Item: Hashable {
    case pushAlarm(model: SettingAlarm)
    case font(model: SettingFont)
    case content(model: SettingContent)
}

struct SettingAlarm: Hashable {
    let id: String = UUID().uuidString
    let imageName: String
    let text: String
    let date: Date
    let switchState: Bool
}

struct SettingFont: Hashable {
    let id: String = UUID().uuidString
    let imageName: String
    let text: String
    let fontName: String
}

struct SettingContent: Hashable {
    let id: String = UUID().uuidString
    let imageName: String
    let text: String
}
