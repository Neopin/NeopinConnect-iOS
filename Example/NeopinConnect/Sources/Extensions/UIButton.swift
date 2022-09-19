//
//  UIButton.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/05.
//
import UIKit

extension UIButton {
    func setBackgroundColor(
        _ color: UIColor,
        forState: UIControl.State
    ) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }
}
