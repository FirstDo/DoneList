//
//  SettingViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/08/08.
//

import SwiftUI
import Combine

protocol SettingViewModelType: ObservableObject {
    var appFont: AppFont { get }
}

final class SettingViewModel: SettingViewModelType {
    @AppStorage(UserDefaultsKey.userFont)
    var appFont: AppFont = FontManager.getFontName()
}
