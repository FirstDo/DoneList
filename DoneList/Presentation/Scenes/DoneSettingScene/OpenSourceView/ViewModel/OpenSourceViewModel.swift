//
//  OpenSourceViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/29.
//

protocol OpenSourceViewModelInput {
    
}

protocol OpenSourceViewModelOutput {
    var item: OpenSource { get }
}

protocol OpenSourceViewModelType: OpenSourceViewModelInput, OpenSourceViewModelOutput {}

final class OpenSourceViewModel: OpenSourceViewModelType {
    let item: OpenSource
    
    init(item: OpenSource) {
        self.item = item
    }
}
