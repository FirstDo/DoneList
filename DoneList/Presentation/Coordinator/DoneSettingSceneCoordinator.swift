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
    
    func showDoneSetting() {
        let doneSettingViewController = dependency.makeDoneSettingViewController()
        doneSettingViewController.coordinator = self
        
        navigationController?.pushViewController(doneSettingViewController, animated: true)
    }
    
    // MARK: - OpenSourceViewController
    
    func showOpenSourceViewController() {
        let viewModel = OpenSoureViewModel(openSources: OpenSource.allOpenSources)
        let viewController = OpenSourceViewController(viewModel)
        viewController.coordinator = self
        
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
