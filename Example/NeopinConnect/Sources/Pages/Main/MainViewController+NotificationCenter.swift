//
//  MainViewController+NotificationCenter.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import Foundation
import UIKit

// MARK: - AddObserver
extension MainViewController {
    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadInputData),
            name: Notification.createName(.updatedWalletSession),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadTextView),
            name: Notification.createName(.updatedConnectLog),
            object: nil
        )
    }
}


// MARK: - RemoveObserver
extension MainViewController {
    func removeObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.createName(.updatedWalletSession),
            object: nil
        )
        
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.createName(.updatedConnectLog),
            object: nil
        )
    }
}


// MARK: - Public Method
extension MainViewController {
    @objc func reloadInputData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let session = ConnectManager.shared.session,
                  let approved = session.walletInfo?.approved,
                  approved else {
                self.connectButtonView.isHidden = false
                self.disconnectButton.isHidden = true
                return
            }
            
            self.connectButtonView.isHidden = true
            self.disconnectButton.isHidden = false
        }
    }
    
    @objc func reloadTextView() {
        DispatchQueue.main.async { [weak self] in
            self?.logTextView.text = ConnectManager.shared.log
            self?.logTextView.textViewScrollToBottom()
        }
    }
}

