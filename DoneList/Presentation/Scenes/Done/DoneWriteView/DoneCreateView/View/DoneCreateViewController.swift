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
    
    private func setupView() {
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
