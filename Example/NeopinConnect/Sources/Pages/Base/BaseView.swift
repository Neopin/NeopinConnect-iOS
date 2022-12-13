//
//  BaseView.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Properties
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        print("DEINIT : \(self.className)")
    }
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
