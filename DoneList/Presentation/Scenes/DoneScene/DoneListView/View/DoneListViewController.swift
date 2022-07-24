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
                self?.mainView.quoteLabel.text = quote.content + "\n" + "- " + quote.person + " -"
            }
            .store(in: &cancelBag)
        
        viewModel.dateTitle
            .sink { [weak self] formattedDate in
                self?.mainView.dateLabel.text = formattedDate
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] message in
                // TODO: Show Alert
            }
            .store(in: &cancelBag)
        
        viewModel.showCalendarView
            .sink { [weak self] date in
                guard let self = self else { return }
                
                self.coordinator?.showCalendar(with: date, changedTargetDate: self.viewModel.didChangeTargetDate(to:))
            }
            .store(in: &cancelBag)
        
        viewModel.showChartView
            .sink { [weak self] date in
                self?.coordinator?.showDoneChart(date)
            }
            .store(in: &cancelBag)
        
        viewModel.showSettingView
            .sink { [weak self] _ in
                // TODO: showSettingView
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneEditView
            .sink { [weak self] done in
                self?.coordinator?.showDoneEdit(item: done)
            }
            .store(in: &cancelBag)
        
        viewModel.showDoneCreateView
            .sink { [weak self] date in
                self?.coordinator?.showDoneCreate(date: date)
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
        
        mainView.doneCollectionView.delegate = self
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

extension DoneListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = collectionView.dataSource as? DoneListView.DataSource,
              let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.didTapCell(with: item)
    }
}
