# Neopin Connect for [Android](https://github.com/Neopin/NeopinConnect-aos), [iOS](https://github.com/Neopin/NeopinConnect-iOS) and [Web](https://neopin.io)

NEOPIN Connect는 DApp과 Neopin Wallet을 보다 쉽고 안전하게 연결하기 위한 서비스로 Ethereum에서 사용되었던 Wallet Connect를 기반으로 구현되었습니다. 

NEOPIN Connect는 브리지 서버를 사용하여 페이로드를 릴레이하는 App-to-App 또는 Web-to-App 간에 원격 연결을 지원합니다. 이러한 페이로드는 두 피어 간의 공유 키를 통해 대칭적으로 암호화되어 안전하게 전달됩니다. App-to-App 또는 Web-to-App 간 연결은 QR 코드 또는 표준 URI가 포함되어 있는 딥링크를 실행하는 DApp에 의해 시작되며 NEOPIN Wallet에서 해당 연결 요청을 승인할 때 설정됩니다. 

현재는 Klaytn 계열의 코인, 토큰만 지원하며, 향후 Ethereum, BSC등 다양한 체인으로 확장할 예정입니다.

# Documentation
To get started with [NeopinConnect](https://docs.neopin.io/enjoy-with-neopin/neopin-connect), please refer to the NeopinConnect documentation. This describes key concepts on NeopinConnect, from what they are for, their structure and common use cases.

# Requirements
- iOS 13
- Swift 5

    
# Dependencies

- [WalletConnect (1.0.1)](https://github.com/WalletConnect/WalletConnectSwift)
- [web3swift](https://github.com/skywinder/web3swift)
- [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)
    
# Installation

Add the pod to your Podfile:

```ruby
pod 'NeopinConnect'
```

And then run:
```
pod install
```

# License

NeopinConnect is available under the MIT license. See the LICENSE file for more info.

# Reference

- [WalletConnect Docs](https://docs.walletconnect.com/)
- [WalletConnectSwift SDK](https://github.com/WalletConnect/WalletConnectSwift)
