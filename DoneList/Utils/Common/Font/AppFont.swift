//
//  AppFont.swift
//  DoneList
//
//  Created by dudu on 2022/08/08.
//

import UIKit
import SwiftUI
import Combine

enum FontSize: CGFloat {
    case largetTitle = 34
    case title1 = 28
    case title2 = 22
    case title3 = 20
    case body = 17
    case callout = 16
    case footnote = 13
    case caption1 = 12
    case caption2 = 11
}

enum AppFont: String, CaseIterable {
    case system = "System"
    case dalseoHealing = "DalseoHealing"
    case mabinogi = "Mabinogi_Classic_OTF"
    case chosunCentennial = "Chosun Centennial"
    
    var name: String {
        switch self {
        case .system:
            return "시스템 폰트"
        case .dalseoHealing:
            return "달서힐링체"
        case .mabinogi:
            return "마비옛체"
        case .chosunCentennial:
            return "조선100년체"
        }
    }
}

final class FontManager {
    static func getFontName() -> AppFont {
        let key = UserDefaults.standard.string(forKey: UserDefaultsKey.userFont) ?? AppFont.system.rawValue
        return AppFont(rawValue: key)!
    }
    
    static func getFontNamePublisher() -> AnyPublisher<AppFont, Never> {
        return UserDefaults.standard
            .publisher(for: \.font)
            .compactMap { key in
                return AppFont(rawValue: key)
            }
            .eraseToAnyPublisher()
    }
    
    static func setFont(_ font: AppFont) {
        UserDefaults.standard.setValue(font.rawValue, forKey: UserDefaultsKey.userFont)
    }
}

extension UIFont {
    static func customFont(_ appFont: AppFont, _ size: FontSize) -> UIFont {
        return UIFont(name: appFont.rawValue, size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
    }
}

extension View {
    func customFont(_ appFont: AppFont, _ size: FontSize) -> some View {
        if appFont == .system {
            return self.font(.system(size: size.rawValue))
        } else {
            return self.font(.custom(appFont.rawValue, size: size.rawValue))
        }
    }
}
