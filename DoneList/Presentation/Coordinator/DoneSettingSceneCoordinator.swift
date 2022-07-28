//
//  DoneSettingSceneCoordinator.swift
//  DoneList
//
//  Created by 김도연 on 2022/07/28.
//

import UIKit

final class DoneSettingSceneCoordinator: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private let dependency: DoneSettingSceneDIContainer
    
    init(navigationController: UINavigationController, dependency: DoneSettingSceneDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    // MARK: - DoneSettingViewController
    
    func showDoneSettingViewController() {
        let doneSettingViewController = dependency.makeDoneSettingViewController()
        doneSettingViewController.coordinator = self
        
        navigationController?.pushViewController(doneSettingViewController, animated: true)
    }
    
    // MARK: - OpenSourceListViewController
    
    func showOpenSourceListViewController() {
        let viewModel = OpenSourceListViewModel(openSources: OpenSource.allOpenSources)
        let viewController = OpenSourceListViewController(viewModel)
        viewController.coordinator = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - OpenSourceViewController
    
    func showOpenSoureViewController(with item: OpenSource) {
        let viewModel = OpenSourceViewModel(item: item)
        let viewController = OpenSourceViewController(viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
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
