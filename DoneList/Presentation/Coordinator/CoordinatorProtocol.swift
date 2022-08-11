//
//  CoordinatorProtocol.swift
//  DoneList
//
//  Created by dudu on 2022/08/11.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
}

extension Coordinator {
    func removeChild(_ child: Coordinator) {
        childCoordinator.removeAll { $0 === child }
    }
}
