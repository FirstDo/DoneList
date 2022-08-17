//
//  DoneChartSceneCoordinator.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

final class ChartSceneCoordinator: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private let dependency: ChartSceneDIContainer
    
    init(navigationController: UINavigationController, dependency: ChartSceneDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    // MARK: ChartViewController
    
    func showChartViewController(_ date: Date) {
        let chartViewController = dependency.makeChartViewController(with: date)
        chartViewController.coordinator = self
        
        navigationController?.topViewController?.present(chartViewController, animated: true)
    }
    
    func dismiss(target viewController: UIViewController?) {
        viewController?.dismiss(animated: true)
        parentCoordinator?.removeChild(self)
    }
    
    deinit {
        debugPrint(self, #function)
    }
}
