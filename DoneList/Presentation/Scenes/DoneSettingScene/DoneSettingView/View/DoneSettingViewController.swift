//
//  DoneSettingViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import UIKit
import Combine

final class DoneSettingViewController: UITableViewController {
    
    weak var coordinator: DoneSettingSceneCoordinator?
    private let viewModel: DoneSettingViewModelType
    private var cancellableBag = Set<AnyCancellable>()
    
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
        bind()
    }
    
    func bind() {
        viewModel.showOpenSourceViewController
            .sink { [weak self] _ in
                self?.coordinator?.showOpenSourceListViewController()
            }
            .store(in: &cancellableBag)
    }
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(PushAlarmCell.self, forCellReuseIdentifier: "push")
        tableView.register(DefaultSettingCell.self, forCellReuseIdentifier: "default")
    }
    
    deinit {
        print(self, #function)
        coordinator?.pop(target: self)
    }
}

// MARK: - UITableViewDataSource

extension DoneSettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "push", for: indexPath) as! PushAlarmCell
            let viewModel = PushAlarmCellViewModel(pushAlarmUseCase: PushAlarmUseCase(notificationManager: LocalNotificationManager()), switchState: true, alarmDate: .now)
            cell.bind(viewModel)
            
            return cell
        case (0, 1):
            return UITableViewCell()
        case (1, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath) as! DefaultSettingCell
            let viewModel = DefaultSettingCellViewModel(row: indexPath.row)
            cell.bind(viewModel)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension DoneSettingViewController {
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            break
        case (1, 0):
            break
        case (1, 1):
            viewModel.didTapOpenSoureCell()
        default:
            break
        }
    }
}

