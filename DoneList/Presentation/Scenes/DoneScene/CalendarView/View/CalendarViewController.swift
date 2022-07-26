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
    
    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.locale = .current
        calendar.placeholderType = .none
        
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerMinimumDissolvedAlpha = .zero
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleFont = .preferredFont(forTextStyle: .title1)
        
        calendar.appearance.titleWeekendColor = .systemGray
        calendar.appearance.weekdayTextColor = .label
        
        calendar.appearance.eventDefaultColor = .systemRed
        calendar.appearance.eventOffset = CGPoint(x: .zero, y: 5)
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .systemRed
        
        return calendar
    }()
    
    init(_ viewModel: CalendarViewModelType) {
        self.viewModel = viewModel
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.dismiss(target: self)
    }
    
    private func bind() {
        viewModel.dismissView
            .sink { [weak self] _ in
                self?.coordinator?.dismiss(target: self)
            }
            .store(in: &cancelBag)
        
        viewModel.selectedDate
            .sink { [weak self] date in
                self?.calendarView.select(date)
            }
            .store(in: &cancelBag)
    }
    
    private func setup() {
        setupLayout()
        setupView()
        setupCalendar()
    }
    
    private func setupLayout() {
        view.addSubviews(calendarView)
        
        calendarView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupCalendar() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return viewModel.numberOfEvent(date.startOfDay)
    }
}

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.didTapCell(date.startOfDay)
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendar.selectedDate == date {
            cell.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        } else {
            cell.titleLabel.font = .systemFont(ofSize: 18)
        }
    }
}
