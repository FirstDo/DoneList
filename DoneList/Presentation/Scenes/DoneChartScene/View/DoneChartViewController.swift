//
//  DoneChartViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit
import Combine

import SnapKit

final class DoneChartViewController: UIViewController {
    
    private let viewModel: DoneChartViewModelType
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ viewModel: DoneChartViewModelType) {
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
