//
//  DoneSceneDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

final class DoneSceneDIContainer {
    struct Dependencies {
        unowned let doneStorage: StorageType
        unowned let apiProvider: APIProvider
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Coordiantor
    
    func makeDoneSceneCoordinator(_ navigationController: UINavigationController) -> DoneSceneCoordiantor {
        return DoneSceneCoordiantor(navigationController: navigationController, dependency: self)
    }
    
    // MARK: - DoneListViewController
    
    func makeDoneListViewController() -> DoneListViewController {
        let viewModel = DoneListViewModel(doneUseCase: makeDoneUseCase(), fetchQuoteUseCase: makeFetchQuoteUseCase())
        
        return DoneListViewController(viewModel)
    }
    
    // MARK: - CalendarViewController
    
    func makeCalendarViewController(_ date: Date, _ changedTargetDate: @escaping (Date) -> ()) -> CalendarViewController {
        let viewModel = CalendarViewModel(date: date, changedTargetDate: changedTargetDate)
        
        return CalendarViewController(viewModel)
    }
    
    // MARK: - DoneCreateViewController
    
    func makeDoneCreateViewController(_ date: Date) -> DoneCreateViewController {
        let viewModel = DoneCreateViewModel(doneUseCase: makeDoneUseCase(), date: date)
        
        return DoneCreateViewController(viewModel)
    }
    
    // MARK: - DoneEditViewController
    
    func makeDoneEditViewController(_ item: Done) -> DoneEditViewController {
        let viewModel = DoneEditViewModel(doneUseCase: makeDoneUseCase(), done: item)
        
        return DoneEditViewController(viewModel)
    }
    
    // MARK: - UseCase
    
    private func makeDoneUseCase() -> DoneUseCaseType {
        return DoneUseCase(repository: makeDoneRepository())
    }
    
    private func makeFetchQuoteUseCase() -> FetchQuoteUseCaseType {
        return FetchQuoteUsecase(repository: makeQuotesRepository())
    }
    
    // MARK: - Repository
    
    private func makeDoneRepository() -> DoneRepositoryType {
        return DoneRepository(storage: dependencies.doneStorage)
    }
    
    private func makeQuotesRepository() -> QuotesRepositoryType {
        return QuotesRepository(apiProvider: dependencies.apiProvider)
    }
}
