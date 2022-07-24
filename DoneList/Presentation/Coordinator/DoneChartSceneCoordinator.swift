//
//  DoneChartSceneCoordinator.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

final class DoneChartSceneCoordinator: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private let dependency: DoneChartSceneDIContainer
    
    init(navigationController: UINavigationController, dependency: DoneChartSceneDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    // MARK: DoneListViewController
    
    func showDoneChart(_ date: Date) {
        let doneChartViewController = dependency.makeDoneChartViewController(date)
        doneChartViewController.coordinator = self
        
        navigationController?.topViewController?.present(doneChartViewController, animated: true)
    }
    
    func dismiss(target view: UIViewController?) {
        view?.dismiss(animated: true)
        parentCoordinator?.removeChild(self)
    }
}
