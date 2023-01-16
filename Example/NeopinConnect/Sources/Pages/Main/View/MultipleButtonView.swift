//
//  MultipleButtonView.swift
//  NeopinConnect_Example
//
//  Created by 성 현 on 2023/01/16.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class MultipleButtonView: BaseView {
    // MARK: - UI
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    } ()
    
    // MARK: - Initializing
    init(titles: [String]) {
        super.init(frame: .zero)
        self.setupUI(titles: titles)
        self.setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MultipleButtonView {
    // MARK: - setupUI
    func setupUI(titles: [String]) {
        self.addSubview(self.buttonStackView)
        
        titles.forEach { [weak self] in
            guard let self = self else { return }
            let buttonView = BaseButton(
                info: (title: $0, fontColor: .white),
                backgroundColor: UIColor(red: 26/255, green: 183/255, blue: 235/255, alpha: 1)
            )
            
            self.buttonStackView.addArrangedSubview(buttonView)
        }
    }
    
    func setupConstraints() {
        self.buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
