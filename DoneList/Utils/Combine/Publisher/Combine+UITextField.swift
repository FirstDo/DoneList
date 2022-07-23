//
//  Combine+UITextField.swift
//  DoneList
//
//  Created by 김도연 on 2022/07/24.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return controlPublisher(for: .editingChanged)
            .compactMap { $0 as? UITextField }
            .compactMap { $0.text ?? ""}
            .eraseToAnyPublisher()
    }
}
