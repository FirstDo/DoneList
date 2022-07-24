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
        static let spcaing: CGFloat = 30
        static let inset: CGFloat = 10
    }
    
    enum DateStack {
        static let spcaing: CGFloat = 5
    }
    
    enum YesterDay {
        static let imageName = "chevron.left.square"
        static let font: UIFont = .preferredFont(forTextStyle: .title2)
    }
    
    enum Tomorrow {
        static let imageName = "chevron.right.square"
        static let font: UIFont = .preferredFont(forTextStyle: .title2)
    }
    
    enum Add {
        static let imageName = "plus.app"
        static let font: UIFont = .preferredFont(forTextStyle: .title2)
    }
    
    enum ListTitle {
        static let text = "✅ Done List"
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
        stackview.spacing = Const.DateStack.spcaing
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Const.YesterDay.imageName)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.YesterDay.font)
        button.configuration = configuration
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Const.Tomorrow.imageName)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.Tomorrow.font)
        button.configuration = configuration
        
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
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = .zero
        
        return label
    }()
    
    let doneListTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Const.ListTitle.text
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    let doneCollectionView: UICollectionView = {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        
        listConfiguration.trailingSwipeActionsConfigurationProvider = { indexPath in
            
            let action = UIContextualAction(style: .destructive, title: "삭제") { _, _, completion in
                
                completion(true)
            }
            
            return UISwipeActionsConfiguration(actions: [action])
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    let addDoneButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.Add.font)
        configuration.image = UIImage(systemName: Const.Add.imageName)
        button.configuration = configuration
        
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
        addSubviews(baseStackView, addDoneButton)
        baseStackView.addArrangedSubviews(dateStackView, quoteLabel, doneListTitle, doneCollectionView)
        dateStackView.addArrangedSubviews(yesterDayButton, dateLabel, tomorrowButton)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide).inset(Const.BaseStack.inset)
        }
        
        doneCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        addDoneButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(baseStackView.safeAreaLayoutGuide)
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