//
//  QRConnectViewController+NotificationCenter.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/25.
//
import Foundation

// MARK: - AddObserver
extension QRConnectViewController {
    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadInputData),
            name: Notification.createName(.updatedWalletSession),
            object: nil
        )
    }
}


// MARK: - RemoveObserver
extension QRConnectViewController {
    func removeObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.createName(.updatedWalletSession),
            object: nil
        )
    }
}
