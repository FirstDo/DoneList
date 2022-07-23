//
//  CalendarViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit
import Combine

import SnapKit
import FSCalendar

class CalendarViewController: UIViewController {

    weak var coordinator: DoneSceneCoordiantor?
    private let viewModel: CalendarViewModelType
    private var cancelBag = Set<AnyCancellable>()
    
    init(_ viewModel: CalendarViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}
