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
    
    private(set) lazy var doneCollectionView: UICollectionView = {
        let layout = makeCollectionLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
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
        baseStackView.addArrangedSubviews(doneInputStackView, doneCollectionView, doneButton)
        doneInputStackView.addArrangedSubviews(doneImageView, doneTextField)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func makeCollectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
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
}
