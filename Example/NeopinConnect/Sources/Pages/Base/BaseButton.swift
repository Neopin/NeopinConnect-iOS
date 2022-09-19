//
//  BaseButton.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/05.
//

import UIKit

class BaseButton: UIButton {
    
    // MARK: - Initializing
    init(
        cornerRadius: CGFloat = 10,
        info: (title: String, fontColor: UIColor?),
        backgroundColor: UIColor
    ) {
        super.init(frame: .zero)
        self.cornerRadius = cornerRadius
        self.setTitle(info.title, for: .normal)
        self.setBackgroundColor(backgroundColor, forState: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
