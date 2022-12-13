//
//  UITextView.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/04.
//
import UIKit

extension UITextView {
    func textViewScrollToBottom() {
        guard self.text.count > 0 else { return }
        let bottomRange = NSMakeRange(self.text.count - 1, 1)
        self.scrollRangeToVisible(bottomRange)
    }
}
