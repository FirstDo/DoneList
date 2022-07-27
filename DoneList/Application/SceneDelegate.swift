//
//  SceneDelegate.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let appDIContainer = AppDIContainer()
    private var appCoordinator: AppCoordinator?
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let rootNavigationController = UINavigationController()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(navigationController: rootNavigationController, dependency: appDIContainer)
        appCoordinator?.start()
        
        LocalNotificationManager().requestAuthorization()
    }
}

