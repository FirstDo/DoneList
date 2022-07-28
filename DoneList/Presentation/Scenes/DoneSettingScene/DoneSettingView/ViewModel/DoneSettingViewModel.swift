//
//  DoneSettingViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import Combine

protocol DoneSettingViewModelInput {
    func didTapOpenSoureCell()
}

protocol DoneSettingViewModelOutput {
    var showOpenSourceViewController: PassthroughSubject<Void, Never> { get }
}

protocol DoneSettingViewModelType: DoneSettingViewModelInput, DoneSettingViewModelOutput { }

final class DoneSettingViewModel: DoneSettingViewModelType {
    let showOpenSourceViewController = PassthroughSubject<Void, Never>()
}

// MARK: - Input

extension DoneSettingViewModel {
    func didTapOpenSoureCell() {
        showOpenSourceViewController.send()
    }
}
