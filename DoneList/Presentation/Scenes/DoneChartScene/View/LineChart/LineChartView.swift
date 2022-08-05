//
//  LineChartView.swift
//  DoneList
//
//  Created by dudu on 2022/07/24.
//

import UIKit

import SnapKit

final class LineChartView: UIView {
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray5
        stackView.layer.cornerRadius = 20
        
        return stackView
    }()
    
    private let firstLineView = LineView()
    private let secondLineView = LineView()
    private let thirdLineView = LineView()
    private let fourLineView = LineView()
    private let fiveLineView = LineView()
    private let sixLineView = LineView()
    private let sevenLineView = LineView()
    
    private lazy var lineViews = [firstLineView, secondLineView, thirdLineView, fourLineView, fiveLineView, sixLineView, sevenLineView]
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(baseStackView)
       
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lineViews.forEach { lineView in
            baseStackView.addArrangedSubviews(lineView)
        }
    }

    func setup(with values: [(taskCount: Int, totalTaskCount: Int)]) {
        zip(lineViews, values).forEach { view, count in
            view.setup(count.taskCount, count.totalTaskCount)
            view.setNeedsDisplay()
            view.setNeedsLayout()
        }
    }
}
