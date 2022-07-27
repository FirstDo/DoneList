//
//  DoneSettingViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import UIKit
import Combine

final class DoneSettingViewController: UITableViewController {
    
    private typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Item>
    
    weak var coordinator: DoneSettingSceneCoordinator?
    private let viewModel: DoneSettingViewModelType
    private var dataSource: DataSource?
    
    init(_ viewModel: DoneSettingViewModelType) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.dismiss()
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            fatalError()
        }
    }
    
    private func applySnapshot(_ items: [Item]) {
        var snapshot = SnapShot()
        snapshot.appendSections([.appSetting, .other])
        
        dataSource?.apply(snapshot)
    }
    
    deinit {
        print(#function)
    }
}
