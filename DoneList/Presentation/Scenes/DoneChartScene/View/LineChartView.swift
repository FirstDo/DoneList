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
    
    private let firstLineView = LineView()
    private let secondLineView = LineView()
    private let thirdLineView = LineView()
    private let fourLineView = LineView()
    private let fiveLineView = LineView()
    private let sixLineView = LineView()
    private let sevenLineView = LineView()
    
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
        
        baseStackView.addArrangedSubviews(firstLineView, secondLineView, thirdLineView, fourLineView, fiveLineView, sixLineView, sevenLineView)
    }
    
    func setup(with values: [CGFloat]) {
        
    }
}

final class LineView: UIView {
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    var taskCount: Int?
    var totalTaskCount: Int?
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        addSubview(countLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // TODO
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let taskCount = taskCount, let totalTaskCount = totalTaskCount else { return }
        let percentage = CGFloat(taskCount) / CGFloat(totalTaskCount)
        
        let path = UIBezierPath()
        let zeroPath = UIBezierPath()
        
        let xPosition = frame.width / 2
        let yPosition = frame.height
        let graphHeight = frame.height * (1 - percentage)
        
        path.move(to: .init(x: xPosition, y: yPosition))
        path.addLine(to: .init(x: xPosition, y: graphHeight))
        
        zeroPath.move(to: .init(x: xPosition, y: yPosition))
        zeroPath.addLine(to: .init(x: xPosition, y: yPosition))
        
        let startPath = zeroPath.cgPath
        let endPath = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1
        animation.fromValue = startPath
        animation.toValue = endPath
        
        let graphLayer = CAShapeLayer()
        graphLayer.strokeColor = UIColor.systemRed.cgColor
        graphLayer.lineWidth = 20
        graphLayer.lineCap = .round
        graphLayer.lineJoin = .round
        graphLayer.path = endPath
        graphLayer.add(animation, forKey: "path")
        
        layer.addSublayer(graphLayer)
    }
}
