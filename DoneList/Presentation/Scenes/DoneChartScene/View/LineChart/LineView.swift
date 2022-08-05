//
//  LineView.swift
//  DoneList
//
//  Created by dudu on 2022/07/26.
//

import UIKit

import Combine

final class LineView: UIView {
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    private var taskCount: Int?
    private var totalTaskCount: Int?
    private var graphLayer: CAShapeLayer!
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
    }
    
    private func setup() {
        addSubview(countLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        countLabel.removeFromSuperview()
        addSubview(countLabel)
        
        guard let taskCount = taskCount, let totalTaskCount = totalTaskCount else { return }

        let percentage = CGFloat(taskCount) / CGFloat(totalTaskCount + 3)
        let graphHeight = frame.height * (1 - percentage) - 40
        
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(graphHeight)
        }
        
        countLabel.text = "\(taskCount)"
    }
    
    override func draw(_ rect: CGRect) {
        guard let taskCount = taskCount, let totalTaskCount = totalTaskCount else { return }
        
        let percentage = CGFloat(taskCount) / CGFloat(totalTaskCount + 3)
        
        if let graphLayer = graphLayer {
            graphLayer.removeFromSuperlayer()
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.countLabel.isHidden = false
        }
        
        graphLayer = CAShapeLayer()

        let path = UIBezierPath()
        let zeroPath = UIBezierPath()
        
        let xPosition = frame.width / 2
        let yPosition = frame.height
        let graphHeight = frame.height * (1 - percentage)
        
        path.move(to: .init(x: xPosition, y: yPosition - 10))
        path.addLine(to: .init(x: xPosition, y: graphHeight - 10))
        
        zeroPath.move(to: .init(x: xPosition, y: yPosition - 10))
        zeroPath.addLine(to: .init(x: xPosition, y: yPosition - 10))
        
        let startPath = zeroPath.cgPath
        let endPath = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1
        animation.fromValue = startPath
        animation.toValue = endPath
        
        graphLayer.strokeColor = UIColor.systemRed.cgColor
        graphLayer.lineWidth = 20
        graphLayer.lineCap = .round
        graphLayer.lineJoin = .round
        graphLayer.path = endPath
        graphLayer.add(animation, forKey: "path")
        
        layer.addSublayer(graphLayer)
        
        CATransaction.commit()
    }
    
    func setup(_ taskCount: Int, _ totalTaskCount: Int) {
        self.taskCount = taskCount
        self.totalTaskCount = totalTaskCount
        self.countLabel.isHidden = true
    }
}
