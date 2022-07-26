//
//  DoneSettingViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import UIKit
import Combine

final class DoneSettingViewController: UITableViewController {
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, Int>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Int>
    
    private var dataSource: DataSource?
    
    private let viewModel: DoneSettingViewModelType
    
    init(_ viewModel: DoneSettingViewModelType) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
