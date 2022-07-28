//
//  OpenSourceViewController.swift
//  DoneList
//
//  Created by dudu on 2022/07/29.
//

import UIKit

final class OpenSourceViewController: UIViewController {
    
    private let openSourceContentTextView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    private let viewModel: OpenSourceViewModelType
    
    init(_ viewModel: OpenSourceViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bind()
    }
    
    private func bind() {
        openSourceContentTextView.text = viewModel.item.content
        title = viewModel.item.name
        
        openSourceContentTextView.layoutIfNeeded()
    }
    
    private func setup() {
        setupLayout()
        setupView()
    }
    
    private func setupLayout() {
        view.addSubview(openSourceContentTextView)
        openSourceContentTextView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
}
