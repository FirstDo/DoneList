//
//  DoneListViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit
import Combine

import SnapKit

final class DoneListViewController: UIViewController {
    
    weak var coordinator: DoneSceneCoordiantor?
    private let viewModel: DoneListViewModelType
    private var mainView: DoneListView
    private var cancelBag = Set<AnyCancellable>()

    init(_ viewModel: DoneListViewModelType) {
        self.viewModel = viewModel
        self.mainView = DoneListView()
        super.init(nibName: nil, bundle: nil)
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
        viewModel.doneItems
            .sink { [weak self] items in
                self?.mainView.applySnapshot(items)
            }
            .store(in: &cancelBag)
        
        viewModel.quote
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quote in
                self?.mainView.quoteLabel.text = quote.quote
            }
            .store(in: &cancelBag)
        
        viewModel.currentDate
            .sink { [weak self] date in
                self?.mainView.dateLabel.text = "20xx.0x.0x"
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] message in
                // TODO: Show Alert
            }
            .store(in: &cancelBag)
        
        viewModel.showCalendarView
            .sink { [weak self] date in
                // TODO: ShowCalendarView
            }
            .store(in: &cancelBag)
        
        viewModel.showChartView
            .sink { [weak self] _ in
                // TODO: ShowChartView
            }
            .store(in: &cancelBag)
        
        viewModel.showSettingView
            .sink { [weak self] _ in
                // TODO: showSettingView
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneEditView
            .sink { [weak self] done in
                // TODO: showDoneEditView
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneCreateView
            .sink { [weak self] _ in
                // TODO: showDoneCreateView
            }
            .store(in: &cancelBag)
    }
    
    private func setup() {
        setupLayout()
        setupView()
        setupNavigationItem()
    }
    
    private func setupLayout() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        mainView.yesterDayButton.addAction(
            UIAction { [weak self] _ in
                self?.viewModel.didTapYesterDayButton()
            },
            for: .touchUpInside
        )
        mainView.tomorrowButton.addAction(
            UIAction { [weak self] _ in
                self?.viewModel.didTapTomorrowButton()
            },
            for: .touchUpInside
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateLabel))
        mainView.dateLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func didTapDateLabel() {
        viewModel.didTapDateLabel()
    }
    
    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chart.pie.fill"),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.didTapChartButton()
            }
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.didTapSettingButton()
            }
        )
    }
}
