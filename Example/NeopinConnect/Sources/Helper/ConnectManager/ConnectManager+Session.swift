//
//  ConnectManager+Session.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import NeopinConnect

extension ConnectManager {
    func addSession(session: NeopinConnect.Session) {
        self.session = session
        NotificationCenter.post(name: .updatedWalletSession)
    }
    
    func removeSession(session: NeopinConnect.Session) {
        self.session = nil
        NotificationCenter.post(name: .updatedWalletSession)
    }
}
