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
        stackview.backgroundColor = .systemGray5
        stackview.layer.cornerRadius = 8
        stackview.layer.borderColor = UIColor.systemGray.cgColor
        stackview.layer.borderWidth = 2.0
        
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.directionalLayoutMargins = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        return stackview
    }()
    
    private let doneTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 2
        
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
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(5)
        }
        
        doneImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
    }
    
    private func apply(with configuration: UIContentConfiguration) {
        guard let doneConfiguration = configuration as? DoneContentConfiguration else { return }
        
        doneTitleLabel.text = doneConfiguration.title
        doneImageView.image = doneConfiguration.image
        doneImageView.tintColor = doneConfiguration.tintColor
    }
}
