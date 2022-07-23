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
    
    // MARK: - ViewController
    
    func makeDoneListViewController() -> DoneListViewController {
        return DoneListViewController(makeDoneListViewModel())
    }
    
    func makeCalendarViewController(_ date: Date, _ changedTargetDate: @escaping (Date) -> ()) -> CalendarViewController {
        return CalendarViewController(makeCalendarViewModel(date, changedTargetDate))
    }
    
    // MARK: - ViewModel
    
    private func makeDoneListViewModel() -> DoneListViewModelType {
        return DoneListViewModel(doneUseCase: makeDoneUseCase(), fetchQuoteUseCase: makeFetchQuoteUseCase())
    }
    
    private func makeCalendarViewModel(_ date: Date, _ changedTargetDate: @escaping (Date) -> ()) -> CalendarViewModelType {
        return CalendarViewModel(date: date, changedTargetDate: changedTargetDate)
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
