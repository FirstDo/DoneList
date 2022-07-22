//
//  DoneListView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

fileprivate enum Const {
    enum BaseStack {
        static let spcaing: CGFloat = 20
        static let inset: CGFloat = 10
    }
    
    enum DateStack {
        static let spacing: CGFloat = 20
    }
    
    enum Image {
        static let yesterDay = "chevron.left.square"
        static let tomorrow = "chevron.right.square"
        static let add = "plus.app"
    }
    
    enum Title {
        static let doneList = "✅ Done List"
    }
}

final class DoneListView: UIView {
    
    private let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = Const.BaseStack.spcaing
        stackview.alignment = .center
        stackview.axis = .vertical
        
        return stackview
    }()

    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = Const.DateStack.spacing
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Const.Image.yesterDay), for: .normal)
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Const.Image.tomorrow), for: .normal)
        
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = .zero
        
        return label
    }()
    
    let doneListTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Const.Title.doneList
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private let doneCollectionView: UICollectionView = {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    let addDoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Const.Image.add), for: .normal)
        
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
        addSubview(baseStackView)
        baseStackView.addArrangedSubviews(dateStackView, quoteLabel, doneListTitle, doneCollectionView)
        dateStackView.addArrangedSubviews(yesterDayButton, dateLabel, tomorrowButton)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(Const.BaseStack.inset)
        }
        
        doneCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
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
