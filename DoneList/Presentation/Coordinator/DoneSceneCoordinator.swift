//
//  DoneSceneCoordinator.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

final class DoneSceneCoordiantor: Coordinator {
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    private let dependency: DoneSceneDIContainer
    
    init(navigationController: UINavigationController, dependency: DoneSceneDIContainer) {
        self.navigationController = navigationController
        self.dependency = dependency
    }
    
    // MARK: DoneListViewController
    
    func showDoneList() {
        let doneListViewController = dependency.makeDoneListViewController()
        doneListViewController.coordinator = self
        
        navigationController?.pushViewController(doneListViewController, animated: true)
    }
    
    // MARK: CalendarViewController
    
    func showCalendar(with date: Date, changedTargetDate: @escaping (Date) -> ()) {
        let calendarViewController = dependency.makeCalendarViewController(date, changedTargetDate)
        calendarViewController.coordinator = self
        
        guard let sheet = calendarViewController.sheetPresentationController else { return }
        
        sheet.detents = [.medium()]
        sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        sheet.preferredCornerRadius = 20
        
        navigationController?.topViewController?.present(calendarViewController, animated: true)
    }
    
    // MARK: DoneCreateViewController
    
    func showDoneCreate(date: Date) {
        let doneCreateViewController = dependency.makeDoneCreateViewController(date)
        doneCreateViewController.coordinator = self
        
        guard let sheet = doneCreateViewController.sheetPresentationController else { return }
        
        sheet.detents = [.medium()]
        sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        sheet.preferredCornerRadius = 20
        
        navigationController?.topViewController?.present(doneCreateViewController, animated: true)
    }
    
    // MARK: DoneEditViewController
    
    func showDoneEdit(item: Done) {
        let doneEditViewController = dependency.makeDoneEditViewController(item)
        doneEditViewController.coordinator = self
        
        guard let sheet = doneEditViewController.sheetPresentationController else { return }
        
        sheet.detents = [.medium()]
        sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        sheet.preferredCornerRadius = 20
        
        navigationController?.topViewController?.present(doneEditViewController, animated: true)
    }
    
    // MARK: DoneChartViewController
    
    func showDoneChart(_ date: Date) {
        guard let navigationController = navigationController else { return }
        
        let doneChartSceneDIContainer = dependency.makeDoneChartSceneDIContainer()
        let doneChartSceneCoordinator = doneChartSceneDIContainer.makeDoneChartSceneCoordinator(navigationController)
        doneChartSceneCoordinator.parentCoordinator = self
        childCoordinator.append(doneChartSceneCoordinator)
        
        doneChartSceneCoordinator.showDoneChart(date)
    }
    
    func dismiss(target view: UIViewController?) {
        view?.dismiss(animated: true)
    }
}
