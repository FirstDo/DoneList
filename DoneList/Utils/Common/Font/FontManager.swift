//
//  FontManager.swift
//  DoneList
//
//  Created by dudu on 2022/08/11.
//

import Foundation

final class FontManager {
    static func getFontName() -> AppFont {
        let key = UserDefaults.standard.string(forKey: UserDefaultsKey.userFont) ?? AppFont.system.rawValue
        return AppFont(rawValue: key)!
    }
    
    static func setFont(_ font: AppFont) {
        UserDefaults.standard.setValue(font.rawValue, forKey: UserDefaultsKey.userFont)
    }
}
