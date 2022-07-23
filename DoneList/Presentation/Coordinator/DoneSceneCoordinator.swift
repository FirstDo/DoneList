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
    
    func dismissCalendar() {
        navigationController?.topViewController?.dismiss(animated: true)
    }
}
