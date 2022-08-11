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
    var navigationTitle: String { get }
    var appSettingSectionHeader: String { get }
    var otherSettingSectionHeader: String { get }
    var otherSettingSectionFootter: String { get }
}

final class SettingViewModel: SettingViewModelType {
    
    @AppStorage(UserDefaultsKey.userFont)
    var appFont: AppFont = FontManager.getFontName()
    
    let navigationTitle = "설정"
    let appSettingSectionHeader = "앱 설정"
    let otherSettingSectionHeader = "기타"
    let otherSettingSectionFootter = "developed by dudu"
}
