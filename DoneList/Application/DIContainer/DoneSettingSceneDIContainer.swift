//
//  DoneSettingSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit

final class DoneSettingSceneDIContainer {
    
    // MARK: - Coordinator
    
    func makeDoneSettingSceneCoordinator(_ navigationController: UINavigationController) -> DoneSettingSceneCoordinator {
        return DoneSettingSceneCoordinator(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - ViewController
    
    func makeDoneSettingViewController() -> DoneSettingViewController {
        let viewModel = DoneSettingViewModel(pushAlarmUseCase: makePushAlarmUseCase())
        
        return DoneSettingViewController(viewModel)
    }
    
    func makePushAlarmUseCase() -> PushAlarmUseCaseType {
        return PushAlarmUseCase(notificationManager: LocalNotificationManager())
    }
}
