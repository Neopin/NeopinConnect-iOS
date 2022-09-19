//
//  ConnectManager.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/02.
//

import NeopinConnect

final class ConnectManager: NSObject {
    // MARK: - Static Properties
    static let shared = ConnectManager()
    static let bridgeServerURL: String = "https://bridge.walletconnect.org"
    
    // MARK: - Public Properties
    var log: String = "Click the Connect button to connect with Neopin Wallet.\n\n"
    var client: NeopinConnect.Client?
    var session: NeopinConnect.Session?
    
    /*
     * name: The name that will be displayed in the NEOPIN Wallet.
     * description: The description to be displayed along with the name (Optional)
     * icons: The icon address to be displayed in the NEOPIN Wallet.
     * url: The URL to be displayed along with the name.
     * appID: Enter the project's Bundle Identifier.
     * deepLink: deepLink is required when connecting to the NEOPIN Wallet or returning to the service app after making a transaction.
     */
    let clientMetaData = NeopinConnect.Session.ClientMeta(
        name: "NEOPIN DApp(Sample)",
        description: "NEOPIN DApp(Sample) description ",
        icons: [URL(string: "https://picsum.photos/300/300")!],
        url: URL(string: "https://neopin.sample.io")!,
        appId: "com.neopin.connect.sample.dapp",
        deepLink: "neopinconnecttosampledapp"
    )

    override init() {
        super.init()
    }
}
