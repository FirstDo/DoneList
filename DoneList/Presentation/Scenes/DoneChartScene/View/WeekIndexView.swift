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
    
    private let mondayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let tuesdayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let wednesdayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let thursdayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let fridayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let saturdayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let sundayLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
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
}
