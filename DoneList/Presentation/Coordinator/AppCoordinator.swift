//
//  AppCoordinator.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
}

extension Coordinator {
    func removeChild(_ child: Coordinator) {
        childCoordinator.removeAll { $0 === child }
    }
}

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
        childCoordinator.append(doneSceneCoordinator)
        
        doneSceneCoordinator.showDoneListViewController()
    }
}
