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
    
    // MARK: DoneSettingViewController
    
    func showDoneSetting() {
        let doneSettingViewController = dependency.makeDoneSettingViewController()
        doneSettingViewController.coordinator = self
        
        navigationController?.topViewController?.present(doneSettingViewController, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        parentCoordinator?.removeChild(self)
    }
    
    deinit {
        print(#function)
    }
}
