//
//  OpenSourceListViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import Combine

protocol OpenSourceListViewModelInput {
    func didTapCell(index: Int)
}
protocol OpenSourceListViewModelOutput {
    var items: [OpenSource] { get }
    var showOpenSourceView: PassthroughSubject<OpenSource, Never> { get }
}
protocol OpenSourceListViewModelType: OpenSourceListViewModelInput, OpenSourceListViewModelOutput {}

final class OpenSourceListViewModel: OpenSourceListViewModelType {
    let items: [OpenSource]
    
    // MARK: - Output
    
    let showOpenSourceView = PassthroughSubject<OpenSource, Never>()
    
    init(openSources: [OpenSource]) {
        self.items = openSources
    }
}

// MARK: - Input

extension OpenSourceListViewModel {
    func didTapCell(index: Int) {
        showOpenSourceView.send(items[index])
    }
}
