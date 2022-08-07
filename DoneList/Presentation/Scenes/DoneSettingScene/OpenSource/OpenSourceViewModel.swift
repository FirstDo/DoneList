//
//  OpenSourceViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/08/07.
//

import Combine

protocol OpenSourceViewModelType: ObservableObject {
    var openSource: OpenSource { get }
}

final class OpenSourceViewModel: OpenSourceViewModelType {
    @Published var openSource: OpenSource
    
    init(openSource: OpenSource) {
        self.openSource = openSource
    }
}


