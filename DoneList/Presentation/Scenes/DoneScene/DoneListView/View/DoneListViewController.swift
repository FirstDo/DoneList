//
//  DoneListViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit
import Combine

import SnapKit
import ToastPresenter

final class DoneListViewController: UIViewController {
    
    weak var coordinator: DoneSceneCoordiantor?
    private let viewModel: DoneListViewModelType
    private var mainView: DoneListView
    private var cancelBag = Set<AnyCancellable>()

    init(_ viewModel: DoneListViewModelType) {
        self.viewModel = viewModel
        self.mainView = DoneListView(viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(self, #function)
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
                let quoteText = quote.content + "\n" + "- " + quote.person + " -"
                self?.mainView.quoteLabel.typeWriterAnimation(text: quoteText, delay: 0.1)
            }
            .store(in: &cancelBag)
        
        viewModel.dateTitle
            .sink { [weak self] formattedDate in
                self?.mainView.dateLabel.text = formattedDate
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] message in
                guard let self = self else { return }
                
                ToastView(message: message)
                    .setImage(UIImage(systemName: "xmark.circle.fill"))
                    .show(in: self.view, position: .top(constant: .zero), holdingTime: 1, fadeAnimationDuration: 1)
            }
            .store(in: &cancelBag)
        
        viewModel.showCalendarView
            .sink { [weak self] date in
                guard let self = self else { return }
                
                self.coordinator?.showCalendarViewController(with: date, changedTargetDate: self.viewModel.didChangeTargetDate(to:))
            }
            .store(in: &cancelBag)
        
        viewModel.showChartView
            .sink { [weak self] date in
                self?.coordinator?.showChartViewController(with: date)
            }
            .store(in: &cancelBag)
        
        viewModel.showSettingView
            .sink { [weak self] _ in
                self?.coordinator?.showSettingViewController()
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneEditView
            .sink { [weak self] done in
                self?.coordinator?.showDoneEditViewController(item: done)
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneCreateView
            .sink { [weak self] date in
                self?.coordinator?.showDoneCreateViewController(date: date)
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
        mainView.yesterDayButton.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.didTapYesterDayButton()
            }
            .store(in: &cancelBag)
        
        mainView.tomorrowButton.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.didTapTomorrowButton()
            }
            .store(in: &cancelBag)
        
        mainView.addDoneButton.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.didTapAddButton()
            }
            .store(in: &cancelBag)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateLabel))
        mainView.dateLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func didTapDateLabel() {
        viewModel.didTapDateLabel()
    }
    
    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chart.bar.fill"),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.didTapChartButton()
            }
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.didTapSettingButton()
            }
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
}
