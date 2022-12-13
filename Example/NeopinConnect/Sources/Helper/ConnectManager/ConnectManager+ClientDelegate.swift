//
//  ConnectManager+ClientDelegate.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/03.
//

import NeopinConnect

extension ConnectManager: ClientDelegate {
    func client(
        _ client: Client,
        didConnect session: Session
    ) {
        print("\(#function) didConnect")
        self.addSession(session: session)
        let log = """
        function: \(#function)
        didConnect Session : \(session)
        """
        self.appendLog(log: log)
    }
    
    func client(
        _ client: Client,
        didConnect url: WCURL
    ) {
        print("\(#function) didConnect")
        let log = """
        function: \(#function)
        didConnect WCURL : \(url)
        """
        self.appendLog(log: log)
    }
    func client(
        _ client: Client,
        didFailToConnect url: WCURL
    ) {
        print("\(#function) didFailToConnect: \(url)")
        let log = """
        function: \(#function)
        didFailToConnect: \(url)
        """
        self.appendLog(log: log)
    }
    
    func client(
        _ client: Client,
        didDisconnect session: Session
    ) {
        print("\(#function) didDisconnect")
        self.removeSession(session: session)
        
        let log = """
        function: \(#function)
        didDisconnect: \(session)
        """
        self.appendLog(log: log)
    }
    
    func client(
        _ client: Client,
        didUpdate session: Session
    ) {
        print("\(#function) didUpdate")
        self.addSession(session: session)
        let log = """
        function: \(#function)
        didUpdate Session : \(session)
        """
        self.appendLog(log: log)
    }
}
