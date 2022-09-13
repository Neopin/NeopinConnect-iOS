//
//  UIView.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/03.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
