//
//  OpenSourceListViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import Combine

protocol OpenSourceListViewModelType: ObservableObject {
    var navigationTitle: String { get }
    var openSources: [OpenSource] { get }
    var appFont: AppFont { get }
}

final class OpenSourceListViewModel: OpenSourceListViewModelType {
    let navigationTitle = "오픈소스"
    @Published var openSources: [OpenSource]
    @Published var appFont = FontManager.getFontName()
    
    init(openSources: [OpenSource] = OpenSource.allOpenSources) {
        self.openSources = openSources
    }
}
