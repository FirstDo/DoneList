//
//  DoneContentView.swift
//  DoneList
//
//  Created by dudu on 2022/07/23.
//

import UIKit

fileprivate enum Const {
    enum Image {
        static let size: CGFloat = 30
    }
    
    enum BaseStack {
        static let spacing: CGFloat = 20
        static let inset: CGFloat = 10
    }
}

final class DoneContentView: UIView, UIContentView {
    
    private let baseStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.alignment = .center
        stackview.spacing = Const.BaseStack.spacing
        
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
            $0.edges.equalTo(self.safeAreaLayoutGuide).inset(Const.BaseStack.inset)
        }
        
        doneImageView.snp.makeConstraints {
            $0.width.height.equalTo(Const.Image.size)
        }
    }
    
    private func apply(with configuration: UIContentConfiguration) {
        guard let doneConfiguration = configuration as? DoneContentConfiguration else { return }
        
        doneTitleLabel.text = doneConfiguration.title
        doneImageView.image = doneConfiguration.image
    }
}
