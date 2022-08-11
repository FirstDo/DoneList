//
//  DoneListView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

import SnapKit

final class DoneListView: UIView {
    
    private let viewModel: DoneListViewModelType
    
    private let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 30
        stackview.alignment = .center
        stackview.axis = .vertical
        
        return stackview
    }()

    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 5
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .label
        configuration.image = UIImage(systemName: "chevron.left.circle")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2))
        button.configuration = configuration
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .label
        configuration.image = UIImage(systemName: "chevron.right.circle")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2))
        button.configuration = configuration
        
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        
        return label
    }()
    
    let doneListTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Done List"
        
        return label
    }()
    
    private(set) lazy var doneCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        
        return collectionView
    }()
    
    let addDoneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus.circle.fill"), for: .normal)
        
        return button
    }()
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Done>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Done>
    
    private var dataSource: DataSource?
    
    init(_ viewModel: DoneListViewModelType) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            $0.edges.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(baseStackView).inset(40)
        }
        
        doneCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        addDoneButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
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
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let item = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            self?.viewModel.didCellSwipe(target: item)
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func applySnapshot(_ items: [Done]) {
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
    
    func setFont(_ appFont: AppFont) {
        dateLabel.font = .customFont(appFont, .largetTitle)
        quoteLabel.font = .customFont(appFont, .title3)
        doneListTitle.font = .customFont(appFont, .title1)
        doneCollectionView.reloadData()
    }
}

extension DoneListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = dataSource,
              let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.didTapCell(with: item)
    }
}
