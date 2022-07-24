//
//  DoneChartView.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

import SnapKit

fileprivate enum Const {
    
    enum DateStack {
        static let spcaing: CGFloat = 5
    }
    
    enum YesterDay {
        static let imageName = "chevron.left"
        static let font: UIFont = .preferredFont(forTextStyle: .title2)
    }
    
    enum Tomorrow {
        static let imageName = "chevron.right"
        static let font: UIFont = .preferredFont(forTextStyle: .title2)
    }
    
    enum Close {
        static let imageName = "xmark.circle"
        static let font: UIFont = .preferredFont(forTextStyle: .title1)
    }
    
    enum viewTitle {
        static let text = "리포트"
    }
}

final class DoneChartView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Const.viewTitle.text
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Const.Close.imageName)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.Close.font)
        button.configuration = configuration
        
        return button
    }()
    
    private let dateStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.spacing = Const.DateStack.spcaing
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    let yesterDayButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Const.YesterDay.imageName)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.YesterDay.font)
        button.configuration = configuration
        
        return button
    }()
    
    let tomorrowButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: Const.Tomorrow.imageName)
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(font: Const.Tomorrow.font)
        button.configuration = configuration
        
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)

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
        
        lineChartView.backgroundColor = .systemGray6
        
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
}
