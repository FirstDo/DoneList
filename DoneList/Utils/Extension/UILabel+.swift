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
            let timer = Timer(timeInterval: delay * Double(index), repeats: false) { [weak self] timer in
                self?.text?.append(letter)
            }
            
            RunLoop.current.add(timer, forMode: .common)
        }
    }
}
