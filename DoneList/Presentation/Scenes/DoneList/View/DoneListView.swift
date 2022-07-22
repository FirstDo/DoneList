//
//  DoneListView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

final class DoneListView: UIView {

    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left.square"), for: .normal)
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right.square"), for: .normal)
        
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date.now.description(with: .current)
        
        return label
    }()
    
    let listTitle: UILabel = {
        let label = UILabel()
        label.text = "Done List!"
        
        return label
    }()
    
    private let doneCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .sidebarPlain))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    let addDoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        
        return button
    }()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Done>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Done>
    
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
        addSubViews(dateStackView, listTitle, doneCollectionView)
        dateStackView.addArrangedSubviews(yesterDayButton, dateLabel, tomorrowButton)
        
        dateStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        listTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateStackView.snp.bottom)
        }
        
        doneCollectionView.snp.makeConstraints {
            $0.top.equalTo(listTitle.snp.bottom)
            $0.bottom.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
    }
    
    private func setupCollectionView() {
        let cellRegistraion = UICollectionView.CellRegistration<DoneCell, Done> { cell, indexPath, item in
            cell.done = item
        }
        
        dataSource = DataSource(collectionView: doneCollectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: item)
        }
    }
    
    func applySnapshot(_ items: [Done]) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}
