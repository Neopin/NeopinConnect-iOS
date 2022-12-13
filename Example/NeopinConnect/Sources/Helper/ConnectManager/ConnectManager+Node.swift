//
//  ConnectManager+Node.swift
//  NeopinConnect_Example
//
//  Created by 성 현 on 2022/10/27.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import web3swift

extension ConnectManager {
    func getNonce(
        nodeURL: String,
        address: String
    ) -> (nonce: Int?, error: String?) {
        guard let node = URL(string: nodeURL) else { return (nil, "NodeURL Error") }
        guard let web3Node = try? Web3.new(node) else { return (nil, "Web3 Create Error") }
        guard let sender = EthereumAddress(address) else { return (nil, "EthereumAddress Error") }
        guard let nonce = try? web3Node.eth.getTransactionCount(address: sender) else { return (nil, "Get TransactionCount Error") }
        return (Int("\(nonce)"), nil)
    }
}
