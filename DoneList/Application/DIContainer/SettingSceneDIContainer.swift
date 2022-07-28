//
//  SettingSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit

final class SettingSceneDIContainer {
    
    // MARK: - Coordinator
    
    func makeSettingSceneCoordinator(_ navigationController: UINavigationController) -> SettingSceneCoordinator {
        return SettingSceneCoordinator(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - ViewController
    
    func makeSettingViewController() -> SettingViewController {
        let viewModel = DoneSettingViewModel()
        
        return SettingViewController(viewModel)
    }
    
    deinit {
        print(self, #function)
    }
}
