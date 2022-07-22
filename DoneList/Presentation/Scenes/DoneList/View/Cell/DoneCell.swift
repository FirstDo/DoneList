//
//  DoneCell.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

final class DoneCell: UICollectionViewListCell {
    var done: Done?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let done = done else { return }

        var configuration = DoneContentConfiguration().updated(for: state)
        configuration.title = done.taskName
        configuration.image = UIImage(systemName: done.imageName)
        
        contentConfiguration = configuration
    }
}
