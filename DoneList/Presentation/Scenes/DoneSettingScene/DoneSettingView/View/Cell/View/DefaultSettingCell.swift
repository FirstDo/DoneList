//
//  DefaultSettingCell.swift
//  DoneList
//
//  Created by dudu on 2022/07/28.
//

import UIKit

import SnapKit

final class DefaultSettingCell: UITableViewCell {
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var viewModel: DefaultSettingCellViewModelType?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DefaultSettingCellViewModelType) {
        self.viewModel = viewModel
        
        iconImageView.image = UIImage(systemName: viewModel.item.imageName)
        titleLabel.text = viewModel.item.titleName
    }
    
    private func setup() {
        setupLayout()
        setupView()
    }
    
    private func setupLayout() {
        contentView.addSubview(baseStackView)
        baseStackView.addArrangedSubviews(iconImageView, titleLabel)
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    private func setupView() {
        accessoryType = .disclosureIndicator
    }
}
