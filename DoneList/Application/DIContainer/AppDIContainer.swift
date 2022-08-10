//
//  AppDIContainer.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

final class AppDIContainer {
    private let apiProvider: APIProvider = APIProvider()
    private let storage: DoneStorageType = DoneMemoryStorage()
    
    func makeDoneSceneDIContainer() -> DoneSceneDIContainer {
        return DoneSceneDIContainer(
            dependencies: DoneSceneDIContainer.Dependencies(
                doneStorage: storage,
                apiProvider: apiProvider
            )
        )
    }
    
    deinit {
        debugPrint(self, #function)
    }
}
