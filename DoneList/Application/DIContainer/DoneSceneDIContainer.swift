//
//  DoneSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

final class DoneSceneDIContainer {
    struct Dependencies {
        unowned let doneStorage: DoneStorageType
        unowned let apiProvider: APIProvider
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - DIContainer
    
    var chartSceneDIContainer: ChartSceneDIContainer {
        return ChartSceneDIContainer(dependencies: ChartSceneDIContainer.Dependencies(doneStorage: dependencies.doneStorage))
    }
    
    // MARK: - Coordiantor
    
    func makeDoneSceneCoordinator(_ navigationController: UINavigationController) -> DoneSceneCoordiantor {
        return DoneSceneCoordiantor(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - DoneListViewController
    
    func makeDoneListViewController() -> DoneListViewController {
        let viewModel = DoneListViewModel(doneUseCase: doneUseCase, fetchQuoteUseCase: fetchQuoteUseCase)
        
        return DoneListViewController(viewModel)
    }
    
    // MARK: - CalendarViewController
    
    func makeCalendarViewController(_ date: Date, _ changedTargetDate: @escaping (Date) -> ()) -> CalendarViewController {
        let viewModel = CalendarViewModel(doneUseCase: doneUseCase, date: date, changedTargetDate: changedTargetDate)
        
        return CalendarViewController(viewModel)
    }
    
    // MARK: - DoneCreateViewController
    
    func makeDoneCreateViewController(_ date: Date) -> DoneCreateViewController {
        let viewModel = DoneCreateViewModel(doneUseCase: doneUseCase, date: date)
        
        return DoneCreateViewController(viewModel)
    }
    
    // MARK: - DoneEditViewController
    
    func makeDoneEditViewController(_ item: Done) -> DoneEditViewController {
        let viewModel = DoneEditViewModel(doneUseCase: doneUseCase, done: item)
        
        return DoneEditViewController(viewModel)
    }
    
    // MARK: - UseCase
    
    private var doneUseCase: DoneUseCaseType {
        return DoneUseCase(repository: doneRepository)
    }
    
    private var fetchQuoteUseCase: FetchQuoteUseCaseType {
        return FetchQuoteUsecase(repository: quotesRepository)
    }
    
    // MARK: - Repository
    
    private var doneRepository: DoneRepositoryType {
        return DoneRepository(storage: dependencies.doneStorage)
    }
    
    private var quotesRepository: QuotesRepositoryType {
        return QuotesRepository(apiProvider: dependencies.apiProvider)
    }
    
    deinit {
        print(self, #function)
    }
}
