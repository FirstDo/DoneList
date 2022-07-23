//
//  DoneCreateViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit
import Combine

import SnapKit

final class DoneCreateViewController: UIViewController {
    
    weak var coordinator: DoneSceneCoordiantor?
    private let viewModel: DoneCreateViewModelType
    private let mainView: DoneWriteView
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ viewModel: DoneCreateViewModelType) {
        self.viewModel = viewModel
        self.mainView = DoneWriteView()
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
        viewModel.cellItems
            .sink { [weak self] items in
                self?.mainView.applySnapshot(items)
            }
            .store(in: &cancelBag)
        
        viewModel.category
            .sink { [weak self] category in
                self?.mainView.doneImageView.image = UIImage(systemName: category.name)
            }
            .store(in: &cancelBag)
        
        viewModel.doneButtonState
            .sink { [weak self] isEnable in
                self?.mainView.doneButton.isEnabled = isEnable
            }
            .store(in: &cancelBag)
        
        viewModel.doneButtonTitle
            .sink { [weak self] title in
                self?.mainView.doneButton.setTitle(title, for: .normal)
                self?.mainView.doneButton.setTitle(title, for: .disabled)
            }
            .store(in: &cancelBag)
        
        viewModel.dismissView
            .sink { [weak self] _ in
                self?.coordinator?.dismissDoneCreate()
            }
            .store(in: &cancelBag)
        
        mainView.doneButton.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.didTapCreateButton()
            }
            .store(in: &cancelBag)
        
        mainView.doneTextField.textPublisher
            .sink { [weak self] text in
                self?.viewModel.didEditTextField(text)
            }
            .store(in: &cancelBag)
    }
    
    private func setup() {
        setupLayout()
        setupCollectionView()
    }
    
    private func setupLayout() {
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        mainView.doneCollectionView.delegate = self
    }
}

extension DoneCreateViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = collectionView.dataSource as? DoneWriteView.DataSource,
              let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.didTapCell(item)
    }
}
