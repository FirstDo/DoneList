//
//  UILabel+.swift
//  DoneList
//
//  Created by dudu on 2022/08/03.
//

import UIKit

extension UILabel {
    func typeWriterAnimation(text: String, delay: TimeInterval) {
        self.text = ""

        for (index, letter) in text.enumerated() {
            Timer.scheduledTimer(withTimeInterval: delay * Double(index), repeats: false) { timer in
                self.text?.append(letter)
            }
        }
    }
}
