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
import ToastPresenter

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
        
        calendar.appearance.titleTodayColor = .systemRed
        calendar.appearance.titleDefaultColor = .label
        calendar.appearance.titleWeekendColor = .systemGray
        calendar.appearance.weekdayTextColor = .label
        
        calendar.appearance.eventSelectionColor = .systemRed
        calendar.appearance.eventDefaultColor = .systemRed
        calendar.appearance.eventOffset = CGPoint(x: .zero, y: 5)
        calendar.appearance.todayColor = .clear
        
        return calendar
    }()
    
    init(_ viewModel: CalendarViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print(self, #function)
        coordinator?.dismiss(target: self)
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
        
        viewModel.showErrorAlert
            .sink { [weak self] message in
                guard let self = self else { return }
                
                ToastView(message: message)
                    .setImage(UIImage(systemName: "xmark.circle.fill"))
                    .show(in: self.view, position: .center(constant: .zero), holdingTime: 1, fadeAnimationDuration: 1)
            }
            .store(in: &cancelBag)
        
        viewModel.reloadCalendar
            .sink { [weak self] _  in
                self?.calendarView.reloadData()
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
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        viewModel.didSwipeCalendar(calendar.currentPage.dayAfter)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return viewModel.willTapCell(date)
    }
    
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
