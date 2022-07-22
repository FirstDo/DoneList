//
//  DoneContentView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

final class DoneContentView: UIView, UIContentView {
    
    private let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.alignment = .center
        
        return stackview
    }()
    
    private let doneTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let doneImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            apply(with: configuration)
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupLayout()
        apply(with: configuration)
    }
    
    private func setupLayout() {
        self.addSubview(baseStackView)
        baseStackView.addArrangedSubviews(doneTitleLabel, doneImageView)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        doneImageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    private func apply(with configuration: UIContentConfiguration) {
        guard let doneConfiguration = configuration as? DoneContentConfiguration else { return }
        
        doneTitleLabel.text = doneConfiguration.title
        doneImageView.image = doneConfiguration.image
    }
}
