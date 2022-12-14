//
//  String.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/17.
//

import Foundation

extension String {
    subscript(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ... end])
    }

    subscript(bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ..< end])
    }

    subscript(bounds: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = endIndex
        return String(self[start ..< end])
    }
}

extension String {
    var withoutHex: String {
        guard isHex else { return self }
        return String(self[2...])
    }
    
    /// Returns true if string starts with "0x"
    public var isHex: Bool {
        return hasPrefix("0x")
    }
    
    public var hex: Data {
        let string = withoutHex
        var array = [UInt8]()
        array.reserveCapacity(string.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = string.hasPrefix("0x") ? 2 : 0
        for char in string.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48 && char.value <= 102 else { return Data() }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                return Data()
            }
            if let b = buffer {
                array.append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            array.append(b)
        }
        return Data(array)
    }
}
