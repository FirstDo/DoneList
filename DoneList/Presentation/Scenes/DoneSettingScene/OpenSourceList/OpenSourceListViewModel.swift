//
//  OpenSourceListViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import Combine

protocol OpenSourceListViewModelType: ObservableObject {
    var openSources: [OpenSource] { get }
}

final class OpenSourceListViewModel: OpenSourceListViewModelType {
    @Published var openSources: [OpenSource]
    
    init(openSources: [OpenSource] = OpenSource.allOpenSources) {
        self.openSources = openSources
    }
}
