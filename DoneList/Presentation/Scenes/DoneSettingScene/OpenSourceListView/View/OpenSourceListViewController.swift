//
//  OpenSourceListViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit

import Combine

class OpenSourceListViewController: UITableViewController {
    
    weak var coordinator: DoneSettingSceneCoordinator?
    private let viewModel: OpenSourceListViewModelType
    private var cancellableBag = Set<AnyCancellable>()
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, OpenSource>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, OpenSource>
    
    private var dataSource: DataSource?
    
    init(_ viewModel: OpenSourceListViewModelType) {
        self.viewModel = viewModel
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func bind() {
        viewModel.showOpenSourceView
            .sink { [weak self] openSource in
                // TODO
            }
            .store(in: &cancellableBag)
        
        applySnapshot(viewModel.items)
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            var content = cell.defaultContentConfiguration()
            content.text = item.name
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
    private func applySnapshot(_ items: [OpenSource]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
    
    deinit {
        print(self, #function)
    }
}

// MARK: - UITableViewDelegate

extension OpenSourceListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCell(index: indexPath.row)
    }
}
