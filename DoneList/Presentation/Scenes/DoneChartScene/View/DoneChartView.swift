//
//  DoneChartView.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

import SnapKit

final class DoneChartView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "리포트"
        
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "xmark.circle")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title1))
        button.configuration = configuration
        button.tintColor = .systemRed
        
        return button
    }()
    
    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = 5
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "chevron.left")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2))
        button.configuration = configuration
        button.tintColor = .label
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .title2))
        button.configuration = configuration
        button.tintColor = .label
        
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center

        return label
    }()
    
    let lineChartView = LineChartView()
    let weekIndexView = WeekIndexView()
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        setupLayout()
        setupView()
    }
    
    private func setupLayout() {
        addSubviews(titleLabel, closeButton, dateStackView, lineChartView, weekIndexView)
        dateStackView.addArrangedSubviews(yesterDayButton, dateLabel, tomorrowButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(5)
        }
        
        dateStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
        }
        
        lineChartView.snp.makeConstraints {
            $0.width.height.equalTo(snp.width).inset(20)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateStackView.snp.bottom).offset(50)
        }

        weekIndexView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(snp.width).inset(20)
            $0.top.equalTo(lineChartView.snp.bottom)
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupFont(_ appFont: AppFont) {
        titleLabel.font = .customFont(appFont, .largetTitle)
        dateLabel.font = .customFont(appFont, .title1)
        
        lineChartView.setFont(appFont)
        weekIndexView.setFont(appFont)
    }
}
