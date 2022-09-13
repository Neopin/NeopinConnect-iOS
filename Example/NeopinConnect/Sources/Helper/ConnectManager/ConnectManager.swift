//
//  ConnectManager.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/02.
//

import NeopinConnect

final class ConnectManager: NSObject {
    // MARK: - Static Properties
    static let shared = ConnectManager()
    static let bridgeServerURL: String = "https://bridge.walletconnect.org"
    
    // MARK: - Public Properties
    var log: String = "Connect 버튼을 눌러 Neopin Wallet과 연결해보세요.\n\n"
    var client: NeopinConnect.Client?
    var session: NeopinConnect.Session?
    
    /*
     * name: 네오핀 지갑에서 보여질 이름입니다.
     * description: name과 함께 보여질 설명입니다 (Optional)
     * icons: 네오핀 지갑에서 보여질 아이콘주소입니다.
     * url: 이름과 함께 표시될 URL입니다.
     * appID: Project의 Bundle Identifier를 넣어주세요.
     * deepLink: 앱에서 사용중인 URL스키마를 넣어주세요.
     */
    let clientMetaData = NeopinConnect.Session.ClientMeta(
        name: "NEOPIN DApp(Sample)",
        description: "NEOPIN DApp(Sample) 입니다. ",
        icons: [URL(string: "https://picsum.photos/300/300")!],
        url: URL(string: "https://neopin.sample.io")!,
        appId: "com.neopin.connect.sample.dapp",
        deepLink: "neopinconnecttosampledapp"
    )

    override init() {
        super.init()
    }
}
