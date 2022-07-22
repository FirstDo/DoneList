//
//  DoneListViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/22.
//

import UIKit
import Combine

final class DoneListViewController: UIViewController {
    
    private let viewModel: DoneListViewModelType
    private var cancelBag = Set<AnyCancellable>()

    init(_ viewModel: DoneListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
