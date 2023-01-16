//
//  Chain.swift
//  NeopinConnect_Example
//
//  Created by 성 현 on 2023/01/16.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

enum Chain: String, Codable, Equatable {
    case klay = "KLAY"
    case eth = "ETH"
    case polygon = "MATIC"
}

extension Chain {
    func getChainID(isMainnet: Bool = false) -> Int {
        switch self {
        case .klay: return isMainnet ? 8217 : 1001
        case .eth: return isMainnet ? 1 : 5
        case .polygon: return isMainnet ? 137 : 80001
        }
    }
    
    static func findChainByChainID(chainID: Int) -> Chain? {
        switch chainID {
        case 8217, 1001: return .klay
        case 1, 5: return .eth
        case 137, 15001, 80001: return .polygon
        default: return nil
        }
    }
}
