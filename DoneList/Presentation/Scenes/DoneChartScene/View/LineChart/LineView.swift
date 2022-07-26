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
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let taskCount = taskCount, let totalTaskCount = totalTaskCount else { return }
        let percentage = CGFloat(taskCount) / CGFloat(totalTaskCount + 1)
        
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
    
    func setup(_ taskCount: Int, _ totalTaskCount: Int) {
        self.taskCount = taskCount
        self.totalTaskCount = totalTaskCount
    }
}
