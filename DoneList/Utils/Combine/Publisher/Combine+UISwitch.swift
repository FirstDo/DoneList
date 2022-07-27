//
//  Combine+UISwitch.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit
import Combine

extension UISwitch {
    var statePublisher: AnyPublisher<Bool, Never> {
        return controlPublisher(for: .valueChanged)
            .map { _ in self.isOn }
            .eraseToAnyPublisher()
    }
}
