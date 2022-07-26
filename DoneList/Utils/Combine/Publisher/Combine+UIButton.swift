//
//  Combine+UIButton.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit
import Combine

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        return controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
