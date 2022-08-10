//
//  ChartSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

final class ChartSceneDIContainer {
    struct Dependencies {
        unowned let doneStorage: DoneStorageType
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Coordinator
    
    func makeChartSceneCoordinator(_ navigationController: UINavigationController) -> ChartSceneCoordinator {
        return ChartSceneCoordinator(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - ViewController
    
    func makeChartViewController(with date: Date) -> ChartViewController {
        let viewModel = DoneChartViewModel(doneUseCase: doneUseCase, targetDate: date)
        
        return ChartViewController(viewModel)
    }
    
    // MARK: - UseCase
    
    private var doneUseCase: DoneUseCaseType {
        return DoneUseCase(repository: doneRepository)
    }
    
    // MARK: - Repository
    
    private var doneRepository: DoneRepositoryType {
        return DoneRepository(storage: dependencies.doneStorage)
    }
    
    deinit {
        debugPrint(self, #function)
    }
}
