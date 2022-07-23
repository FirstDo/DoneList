//
//  DoneWriteView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

final class DoneWriteView: UIView {
    
    private let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        
        return stackview
    }()
    
    private let doneInputStackView: UIStackView = {
        let stackview = UIStackView()
        
        return stackview
    }()
    
    private let doneImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let doneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "오늘 한 일을 적어보세요 :)"
        
        return textField
    }()
    
    private let doneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        
        return collectionView
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(baseStackView)
        baseStackView.addArrangedSubviews(doneInputStackView, doneCollectionView, doneButton)
        doneInputStackView.addArrangedSubviews(doneImageView, doneTextField)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
