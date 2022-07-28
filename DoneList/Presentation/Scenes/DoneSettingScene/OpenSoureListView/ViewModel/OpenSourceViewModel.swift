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
    var showOpenSourceModalView: PassthroughSubject<OpenSource, Never> { get }
}
protocol OpenSoureViewModelType: OpenSoureViewModelInput, OpenSoureViewModelOutput {}

final class OpenSoureViewModel: OpenSoureViewModelType {
    private let openSources: [OpenSource]
    
    // MARK: - Output
    
    let showOpenSourceModalView = PassthroughSubject<OpenSource, Never>()
    
    init(openSources: [OpenSource]) {
        self.openSources = openSources
    }
}

// MARK: - Input

extension OpenSoureViewModel {
    func didTapCell(index: Int) {
        showOpenSourceModalView.send(openSources[index])
    }
}
