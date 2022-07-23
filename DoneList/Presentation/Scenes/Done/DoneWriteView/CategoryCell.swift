//
//  CategoryCell.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

class CategoryCell: UICollectionViewCell {
    private let doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(doneImageView)
        
        doneImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(with item: Category) {
        doneImageView.image = UIImage(systemName: item.name)
    }
}
