//
//  OpenSourceViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import Combine

protocol OpenSoureViewModelInput {
    func didTapCell(index: Int)
}
protocol OpenSoureViewModelOutput {
    var items: [OpenSource] { get }
    var showOpenSourceModalView: PassthroughSubject<OpenSource, Never> { get }
}
protocol OpenSoureViewModelType: OpenSoureViewModelInput, OpenSoureViewModelOutput {}

final class OpenSoureViewModel: OpenSoureViewModelType {
    let items: [OpenSource]
    
    // MARK: - Output
    
    let showOpenSourceModalView = PassthroughSubject<OpenSource, Never>()
    
    init(openSources: [OpenSource]) {
        self.items = openSources
    }
}

// MARK: - Input

extension OpenSoureViewModel {
    func didTapCell(index: Int) {
        showOpenSourceModalView.send(items[index])
    }
}
