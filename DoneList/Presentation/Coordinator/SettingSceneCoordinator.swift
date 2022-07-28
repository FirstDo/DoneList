//
//  SettingSceneCoordinator.swift
//  DoneList
//
//  Created by 김도연 on 2022/07/28.
//

import UIKit

final class SettingSceneCoordinator: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private let dependency: SettingSceneDIContainer
    
    init(navigationController: UINavigationController, dependency: SettingSceneDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    // MARK: - DoneSettingViewController
    
    func showDoneSettingViewController() {
        let doneSettingViewController = dependency.makeSettingViewController()
        doneSettingViewController.coordinator = self
        
        navigationController?.pushViewController(doneSettingViewController, animated: true)
    }
    
    // MARK: - OpenSourceListViewController
    
    func showOpenSourceListViewController() {
        let viewModel = OpenSourceListViewModel(openSources: OpenSource.allOpenSources)
        let openSourceListViewController = OpenSourceListViewController(viewModel)
        openSourceListViewController.coordinator = self
        
        navigationController?.pushViewController(openSourceListViewController, animated: true)
    }
    
    // MARK: - OpenSourceViewController
    
    func showOpenSoureViewController(with item: OpenSource) {
        let viewModel = OpenSourceViewModel(item: item)
        let openSourceViewController = OpenSourceViewController(viewModel)
        
        navigationController?.pushViewController(openSourceViewController, animated: true)
    }
    
    func pop(target viewController: UIViewController?) {
        if navigationController?.topViewController == viewController {
            navigationController?.popViewController(animated: true)
        }
        
        parentCoordinator?.removeChild(self)
    }
    
    deinit {
        print(self, #function)
    }
}
