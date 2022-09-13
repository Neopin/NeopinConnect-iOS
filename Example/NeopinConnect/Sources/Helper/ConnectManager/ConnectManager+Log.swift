//
//  ConnectManager+Log.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/03.
//

import Foundation

extension ConnectManager {
    func appendLog(log: String) {
        self.log.append("\n\(log)\n")
        NotificationCenter.post(name: .updatedConnectLog)
    }
}
