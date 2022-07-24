//
//  AppDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

final class AppDIContainer {
    private let apiProvider: APIProvider = APIProvider()
    private let storage: StorageType = MemoryStorage()
    
    func makeDoneSceneDIContainer() -> DoneSceneDIContainer {
        return DoneSceneDIContainer(dependencies: DoneSceneDIContainer.Dependencies(doneStorage: storage, apiProvider: apiProvider))
    }
    
    func makeDoneChartSceneDIContainer() -> DoneChartSceneDIContainer {
        return DoneChartSceneDIContainer(dependencies: DoneChartSceneDIContainer.Dependencies(doneStorage: storage))
    }
}
