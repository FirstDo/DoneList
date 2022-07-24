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
        
        return stackView
    }()
    
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
    }
    
    func setup(with values: [CGFloat]) {
        values.forEach { value in
            baseStackView.addArrangedSubviews(LineView(value: value))
        }
    }
}

final class LineView: UIView {
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private let value: CGFloat
    
    init(value: CGFloat) {
        self.value = value
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(countLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
