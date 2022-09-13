//
//  ConnectManager+Connect.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/03.
//
import NeopinConnect

extension ConnectManager {
    func connect() -> String? {
        guard let randomKey = try? self.createRandomKey() else { return nil }
        guard let url = URL(string: ConnectManager.bridgeServerURL) else { return nil }
        let wcURL = NeopinConnect.WCURL(
            topic: UUID().uuidString,
            bridgeURL: url,
            key: randomKey
        )
        
        let dAppInfo = NeopinConnect.Session.DAppInfo(
            peerId: UUID().uuidString,
            peerMeta: self.clientMetaData
        )
        
        if self.client == nil {
            self.client = NeopinConnect.Client(
                delegate: self,
                dAppInfo: dAppInfo
            )
        }
        do {
            /*
             * name: 네오핀 지갑에서 보여질 이름입니다.
             * description: name과 함께 보여질 설명입니다 (Optional)
             * icons: 네오핀 지갑에서 보여질 아이콘주소입니다.
             * url: 이름과 함께 표시될 URL입니다.
             */
            
            let connectLog = """
            function: \(#function)
            peerID: \(UUID().uuidString),
            peerMetaName: \(self.clientMetaData.name),
            peerMetaDescription: \(self.clientMetaData.description ?? "")
            peerMetaIcons: \(self.clientMetaData.icons),
            peerMdataURL: \(self.clientMetaData.url)
            """
            self.appendLog(log: connectLog)
            try self.client?.connect(to: wcURL)
        } catch {
            print("Client Connect Error: \(error)")
        }
        
        return wcURL.absoluteString
    }
    
    func disconnect(){
        guard let session = self.session else { return }
        do {
            try self.client?.disconnect(from: session)
        } catch {
            print("Current Session is Nil: \(error)")
        }
    }
}

private extension ConnectManager {
    func createRandomKey() throws -> String {
        var bytes = [Int8](repeating: 0, count: 32)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if status == errSecSuccess {
            return Data(bytes: bytes, count: 32).toHexString()
        } else {
            // we don't care in the example app
            enum TestError: Error {
                case unknown
            }
            throw TestError.unknown
        }
    }
}
