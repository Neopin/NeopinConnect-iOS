//
//  ConnectManager+Send.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import NeopinConnect
import web3swift
import BigInt

extension ConnectManager {
    // MARK: - getMyAccount
    func getMyAccount(){
        guard let session = self.session,
              let from = session.walletInfo?.accounts.first else { return }
        
        let log = """
        function: \(#function)
        account: \(from)
        """
        self.appendLog(log: log)
    }
    
    
    func requestPersonalSign() {
        guard let session = self.session,
              let from = session.walletInfo?.accounts.first else { return }
        guard let url = ConnectManager.shared.session?.url else { return }
        
        do {
            try ConnectManager.shared.client?.personal_sign(
                url: url,
                message: "Test",
                account: from,
                completion: { [weak self] response in
                    guard let self = self else { return }
                    do {
                        if let error = response.error {
                            let log = """
                            function: \(#function)
                            error: \(error)
                            """
                            self.appendLog(log: log)
                            return
                        }
                        
                        let result = try response.result(as: String.self)
                        print("requestSendTransaction: \(result)")

                        ABIHelper.decodedABIInfo(data: result)
                        let log = """
                        function: \(#function)
                        result: \(result)
                        """
                        self.appendLog(log: log)
                    } catch {
                        print("\(#function) error: \(error)")
                        let log = """
                        function: \(#function)
                        response.result error: \(response.error?.localizedDescription ?? "")
                        """
                        self.appendLog(log: log)
                    }
                }
            )
        } catch {
            print("\(#function) error: \(error)")
            let log = """
            function: \(#function)
            response.result error: \(error.localizedDescription )
            """
            self.appendLog(log: log)
        }

    }
    
    // MARK: - requestSendTransaction
    func requestSendTransaction(chain: Chain){
        guard let session = self.session,
              let from = session.walletInfo?.accounts.first else { return }

        guard let transaction = Stub.transaction(
            from: from,
            to: "0xb093add5a8ad3e997ccbde6d12dfb2e0c2befbb7",
            chain: chain
        ) else { return }
        
        do {
            try self.client?.eth_sendTransaction(
                url: session.url,
                transaction: transaction,
                completion: { [weak self] response in
                    guard let self = self else { return }
                    do {
                        if let error = response.error {
                            let log = """
                            function: \(#function)
                            error: \(error)
                            """
                            self.appendLog(log: log)
                            return
                        }
                        
                        let result = try response.result(as: String.self)
                        print("requestSendTransaction: \(result)")

                        ABIHelper.decodedABIInfo(data: result)
                        let log = """
                        function: \(#function)
                        result: \(result)
                        """
                        self.appendLog(log: log)
                    } catch {
                        print("\(#function) error: \(error)")
                        let log = """
                        function: \(#function)
                        response.result error: \(response.error?.localizedDescription ?? "")
                        """
                        self.appendLog(log: log)
                    }
                }
            )
        } catch {
            let log = """
            function: \(#function)
            eth_sendTransaction error: \(error)
            """
            self.appendLog(log: log)
        }
    }
}

/// https://docs.walletconnect.org/json-rpc-api-methods/ethereum#example-parameters-1
/// "0xb093add5a8ad3e997ccbde6d12dfb2e0c2befbb7"
fileprivate enum Stub {
    static func transaction(
        from address: String,
        to: String,
        chain: Chain
    ) -> Client.Transaction? {
        // MARK: - transferFucntion(address, value)
        guard let amount = Web3.Utils.parseToBigUInt("10000", units: .eth) else { return nil }
        guard let data = ABIHelper.encode(
            param: [
                to as AnyObject,
                amount as AnyObject
            ],
            function: ABIHelper.getTransferFunction()
        ) else { return nil }

        return NeopinConnect.Client.Transaction(
            from: address,
            to: to,
            data: data,
            gas: "0x76c0",
            gasPrice: "0x",
            value: "0x",
            nonce: nil, // If sent as nil, Update to the latest nonce from the NEOPIN Wallet.
            type: nil,
            accessList: nil,
            chainId: "\(chain.getChainID())",
            maxPriorityFeePerGas: nil,
            maxFeePerGas: nil
        )
    }

    /// https://docs.walletconnect.org/json-rpc-api-methods/ethereum#example-5
    /// ERC20 - transfer(address: BigInt)
//    static let data = "0xa9059cbb000000000000000000000000b51466925d4a2733de8eeb49221657f00984c9af00000000000000000000000000000000000000000000000029a2241af62c0000"
}
