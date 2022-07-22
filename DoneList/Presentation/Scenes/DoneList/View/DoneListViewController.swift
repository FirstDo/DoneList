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
