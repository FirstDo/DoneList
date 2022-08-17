//
//  ChartViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit
import Combine

import SnapKit
import ToastPresenter

final class ChartViewController: UIViewController {
    weak var coordinator: ChartSceneCoordinator?
    private let mainView: DoneChartView
    private let viewModel: DoneChartViewModelType
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ viewModel: DoneChartViewModelType) {
        self.viewModel = viewModel
        self.mainView = DoneChartView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint(self, #function)
        coordinator?.dismiss(target: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func bind() {
        viewModel.dateTitle
            .sink { [weak self] title in
                self?.mainView.dateLabel.text = title
            }
            .store(in: &cancelBag)
        
        viewModel.weekIndexTitle
            .sink { [weak self] dates in
                self?.mainView.weekIndexView.setup(with: dates)
            }
            .store(in: &cancelBag)
        
        viewModel.graphValues
            .sink { [weak self] values in
                self?.mainView.lineChartView.setup(with: values)
                self?.mainView.lineChartView.setNeedsDisplay()
            }
            .store(in: &cancelBag)
        
        viewModel.showErrorAlert
            .sink { [weak self] message in
                guard let self = self else { return }
                
                ToastView(message: message)
                    .setImage(.xmarkCircleFill)
                    .show(in: self.view, position: .bottom(constant: 20), holdingTime: 1, fadeAnimationDuration: 1)
            }
            .store(in: &cancelBag)
        
        viewModel.dismissView
            .sink { [weak self] _ in
                self?.coordinator?.dismiss(target: self)
            }
            .store(in: &cancelBag)
        
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
        
        mainView.closeButton.tapPublisher
            .sink { [weak self] _  in
                self?.viewModel.didTapCloseButton()
            }
            .store(in: &cancelBag)
        
        mainView.setupFont(viewModel.appFont)
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
