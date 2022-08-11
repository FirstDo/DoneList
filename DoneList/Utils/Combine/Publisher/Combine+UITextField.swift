//
//  Combine+UITextField.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return controlPublisher(for: .editingChanged)
            .map { _ in self.text ?? ""}
            .eraseToAnyPublisher()
    }
}
