//
//  Combine+UIDatePicker.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit
import Combine

extension UIDatePicker {
    var datePublisher: AnyPublisher<Date, Never> {
        return controlPublisher(for: .valueChanged)
            .map { _ in self.date }
            .eraseToAnyPublisher()
    }
}
