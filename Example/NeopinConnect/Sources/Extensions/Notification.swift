//
//  Notification.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import UIKit

enum NotificationNames: String, Equatable {
    case updatedWalletSession = "UPDATED_WALLET_SESSION"
    case updatedConnectLog = "UPDATED_CONNECT_LOG"
}

extension Notification{
    static func createName(_ name: NotificationNames) -> Notification.Name {
        return Notification.Name(name.rawValue)
    }
}

extension NotificationCenter {
    static func post(
        name: NotificationNames,
        userInfo: [AnyHashable: Any] = [:]
    ){
        NotificationCenter.default.post(
            name: Notification.createName(name),
            object: nil,
            userInfo: userInfo
        )
    }
}
