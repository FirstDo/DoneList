//
//  AppCoordinator.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private unowned let dependency: AppDIContainer
    
    init(navigationController: UINavigationController, dependency: AppDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    func start() {
        guard let navigationController = navigationController else { return }
        
        let doneSceneDIContainer = dependency.makeDoneSceneDIContainer()
        let doneSceneCoordinator = doneSceneDIContainer.makeDoneSceneCoordinator(navigationController)
        
        doneSceneCoordinator.parentCoordinator = self
        doneSceneCoordinator.showDoneListViewController()
        
        childCoordinator.append(doneSceneCoordinator)
    }
    
    deinit {
        debugPrint(self, #function)
    }
}
