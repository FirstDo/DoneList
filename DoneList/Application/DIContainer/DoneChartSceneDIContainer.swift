//
//  DoneChartSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

final class DoneChartSceneDIContainer {
    struct Dependencies {
        unowned let doneStorage: StorageType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Coordinator
    
    func makeDoneChartSceneCoordinator(_ navigationController: UINavigationController) -> DoneChartSceneCoordinator {
        return DoneChartSceneCoordinator(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - ViewController
    
    func makeDoneChartViewController(_ date: Date) -> DoneChartViewController {
        let viewModel = DoneChartViewModel(doneUseCase: makeDoneUseCase(), targetDate: date)
        
        return DoneChartViewController(viewModel)
    }
    
    // MARK: - UseCase
    
    private func makeDoneUseCase() -> DoneUseCaseType {
        return DoneUseCase(repository: makeDoneRepository())
    }
    
    // MARK: - Repository
    
    private func makeDoneRepository() -> DoneRepositoryType {
        return DoneRepository(storage: dependencies.doneStorage)
    }
}
