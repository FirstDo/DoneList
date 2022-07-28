//
//  PushAlarmCell.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit
import Combine

import SnapKit

final class PushAlarmCell: UITableViewCell {
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "swift"))
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "푸쉬 알람"
        
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 10
        
        return datePicker
    }()
    
    private let alarmSwitch: UISwitch = {
        let `switch` = UISwitch()
        
        return `switch`
    }()
    
    private var viewModel: PushAlarmCellViewModelType?
    private var cancellableBag = Set<AnyCancellable>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PushAlarmCellViewModelType) {
        self.viewModel = viewModel
        
        viewModel.switchState
            .sink { [weak self] state in
                self?.alarmSwitch.isOn = state
                self?.datePicker.isEnabled = state
            }
            .store(in: &cancellableBag)
        
        viewModel.alarmDate
            .sink { [weak self] date in
                self?.datePicker.date = date
            }
            .store(in: &cancellableBag)
        
        alarmSwitch.statePublisher
            .sink { [weak self] state in
                switch state {
                case true:
                    self?.viewModel?.didOnSwitch()
                case false:
                    self?.viewModel?.didOffSwitch()
                }
            }
            .store(in: &cancellableBag)
        
        datePicker.datePublisher
            .sink { [weak self] date in
                self?.viewModel?.didChangeDate(to: date)
            }
            .store(in: &cancellableBag)
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(baseStackView)
        baseStackView.addArrangedSubviews(iconImageView, titleLabel, datePicker, alarmSwitch)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
