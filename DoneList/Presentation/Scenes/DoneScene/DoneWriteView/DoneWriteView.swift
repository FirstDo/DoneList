//
//  DoneWriteView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

final class DoneWriteView: UIView {
    let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.directionalLayoutMargins = .init(top: 30, leading: 30, bottom: .zero, trailing: 30)
        
        return stackview
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private let doneInputStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 20
        stackview.layer.cornerRadius = 10
        stackview.backgroundColor = .systemBackground
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.directionalLayoutMargins = .init(top: 5, leading: 5, bottom: 5, trailing: .zero)
        
        return stackview
    }()
    
    let doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.app")
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    let doneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "오늘 한 일을 적어보세요 :)"
        textField.enablesReturnKeyAutomatically = true
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        
        return textField
    }()
    
    private(set) lazy var doneCollectionView: UICollectionView = {
        let layout = makeCollectionLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemGreen, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        
        return button
    }()
    
    private let dummyView = UIView()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Category>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Category>
    
    private var dataSource: DataSource?
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        setupLayout()
        setupView()
        setupCollectionView()
    }
    
    private func setupLayout() {
        addSubview(baseStackView)
        baseStackView.addArrangedSubviews(titleLabel, doneInputStackView, doneCollectionView, doneButton, dummyView)
        doneInputStackView.addArrangedSubviews(doneImageView, doneTextField)
        
        baseStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        doneImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        doneCollectionView.snp.makeConstraints {
            $0.height.equalTo(baseStackView).multipliedBy(0.45)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemGray6
        doneTextField.delegate = self
    }
    
    private func makeCollectionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            let width = environment.container.effectiveContentSize.width / 4
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(width))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            return NSCollectionLayoutSection(group: group)
        }
    }
    
    private func setupCollectionView() {
        let cellRegistraion = UICollectionView.CellRegistration<CategoryCell, Category> { cell, indexPath, item in
            cell.setup(with: item)
        }
        
        dataSource = DataSource(collectionView: doneCollectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: item)
        }
    }
    
    func applySnapshot(_ items: [Category]) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
    
    func setFont(_ appFont: AppFont) {
        titleLabel.font = .customFont(appFont, .title3)
        doneButton.titleLabel?.font = .customFont(appFont, .body)
        doneTextField.font = .customFont(appFont, .body)
    }
}

extension DoneWriteView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
