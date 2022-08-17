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
        stackview.spacing = 20
        stackview.layer.cornerRadius = 8
        
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.directionalLayoutMargins = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        return stackview
    }()
    
    private let doneTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
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
        
        baseStackView.addArrangedSubviews(doneImageView, doneTitleLabel)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
        
        doneImageView.snp.makeConstraints {
            $0.width.height.lessThanOrEqualTo(40)
        }
    }
    
    private func apply(with configuration: UIContentConfiguration) {
        guard let doneConfiguration = configuration as? DoneContentConfiguration else { return }
        
        doneTitleLabel.text = doneConfiguration.title
        doneTitleLabel.font = doneConfiguration.font
        doneImageView.image = doneConfiguration.image
        baseStackView.backgroundColor = doneConfiguration.themeColor
    }
}
