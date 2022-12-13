//
//  Decimal.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/17.
//

import Foundation

extension Decimal {    
    func enumeratePrecision(precision: Int) -> String {
        let number = NumberFormatter()
        number.minimumFractionDigits = precision
        number.maximumFractionDigits = precision
        number.roundingMode = .floor
        number.numberStyle = .none
        return number.string(for: self) ?? ""
    }
}
