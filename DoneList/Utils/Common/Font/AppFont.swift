//
//  AppFont.swift
//  DoneList
//
//  Created by dudu on 2022/08/08.
//

import UIKit
import SwiftUI

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
