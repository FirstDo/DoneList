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
}

final class OpenSourceListViewModel: OpenSourceListViewModelType {
    
    @Published var openSources: [OpenSource]
    let navigationTitle = "오픈소스"
    
    init(openSources: [OpenSource] = OpenSource.allOpenSources) {
        self.openSources = openSources
    }
}
