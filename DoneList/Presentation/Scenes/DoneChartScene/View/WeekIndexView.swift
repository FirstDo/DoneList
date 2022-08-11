//
//  WeekIndexView.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

import SnapKit

final class WeekIndexView: UIView {
    
    private let weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let mondayLabel = UILabel(alignment: .center)
    private let tuesdayLabel = UILabel(alignment: .center)
    private let wednesdayLabel = UILabel(alignment: .center)
    private let thursdayLabel = UILabel(alignment: .center)
    private let fridayLabel = UILabel(alignment: .center)
    private let saturdayLabel = UILabel(alignment: .center)
    private let sundayLabel = UILabel(alignment: .center)
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubviews(weekStackView)
        weekStackView.addArrangedSubviews(mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel)
        
        weekStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setup(with week: [String]) {
        mondayLabel.text = week[0]
        tuesdayLabel.text = week[1]
        wednesdayLabel.text = week[2]
        thursdayLabel.text = week[3]
        fridayLabel.text = week[4]
        saturdayLabel.text = week[5]
        sundayLabel.text = week[6]
    }
    
    func setFont(_ appFont: AppFont) {
        mondayLabel.font = .customFont(appFont, .body)
        tuesdayLabel.font = .customFont(appFont, .body)
        wednesdayLabel.font = .customFont(appFont, .body)
        thursdayLabel.font = .customFont(appFont, .body)
        fridayLabel.font = .customFont(appFont, .body)
        saturdayLabel.font = .customFont(appFont, .body)
        sundayLabel.font = .customFont(appFont, .body)
    }
}

private extension UILabel {
    convenience init(alignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = alignment
    }
}
