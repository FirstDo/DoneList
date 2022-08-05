//
//  SettingViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/27.
//

import UIKit
import Combine

final class SettingViewController: UITableViewController {
    
    weak var coordinator: SettingSceneCoordinator?
    private let viewModel: DoneSettingViewModelType
    private var cancellableBag = Set<AnyCancellable>()
    
    init(_ viewModel: DoneSettingViewModelType) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(self, #function)
        coordinator?.pop(target: self)
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
        tableView.register(PushAlarmCell.self, forCellReuseIdentifier: PushAlarmCell.identifier)
        tableView.register(DefaultSettingCell.self, forCellReuseIdentifier: DefaultSettingCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PushAlarmCell.identifier, for: indexPath) as? PushAlarmCell else {
                return UITableViewCell()
            }
            
            let viewModel = PushAlarmCellViewModel(pushAlarmUseCase: PushAlarmUseCase(notificationManager: LocalNotificationManager()), switchState: true, alarmDate: .now)
            cell.bind(viewModel)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingCell.identifier, for: indexPath) as? DefaultSettingCell else {
                return UITableViewCell()
            }
            
            let viewModel = DefaultSettingCellViewModel(row: indexPath.row)
            cell.bind(viewModel)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController {
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        viewModel.willSelectRowAt(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.didTapAppStoreReviewCell()
        case 1:
            viewModel.didTapOpenSoureCell()
        default:
            break
        }
    }
}

