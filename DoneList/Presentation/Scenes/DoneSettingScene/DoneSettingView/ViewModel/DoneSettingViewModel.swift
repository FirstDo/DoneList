//
//  DoneSettingViewModel.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import Combine
import Foundation

protocol DoneSettingViewModelInput {
    func didTapOpenSoureCell()
    func didTapAppStoreReviewCell()
    func numberOfSections() -> Int
    func numberOfRowsInSection(_ section: Int) -> Int
    func willSelectRowAt(_ indexPath: IndexPath) -> IndexPath?
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
    
    func didTapAppStoreReviewCell() {
        // TODO
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func willSelectRowAt(_ indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
}
