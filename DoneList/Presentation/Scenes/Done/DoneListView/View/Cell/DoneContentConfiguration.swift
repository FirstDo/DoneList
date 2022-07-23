//
//  DoneContentConfiguration.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

struct DoneContentConfiguration: UIContentConfiguration {
    
    var title: String?
    var image: UIImage?
    var tintColor: UIColor?
    
    func makeContentView() -> UIView & UIContentView {
        return DoneContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> DoneContentConfiguration {
        return self
    }
}
