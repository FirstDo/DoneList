//
//  OpenSourceViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import Combine

protocol OpenSourceViewModelType: ObservableObject {
    var openSource: OpenSource { get }
    var appFont: AppFont { get }
}

final class OpenSourceViewModel: OpenSourceViewModelType {
    @Published var appFont = FontManager.getFontName()
    @Published var openSource: OpenSource
    
    init(openSource: OpenSource) {
        self.openSource = openSource
    }
}


