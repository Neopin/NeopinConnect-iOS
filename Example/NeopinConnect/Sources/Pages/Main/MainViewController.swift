//
//  MainViewController.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/02.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    
    // MARK: - UI
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.cornerRadius = 12
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(self.topInsetView)
        stackView.addArrangedSubview(self.connectButtonView)
        stackView.addArrangedSubview(self.disconnectButton)
        stackView.addArrangedSubview(self.getAccountButton)
        stackView.addArrangedSubview(self.sendTransactionButton)
        stackView.addArrangedSubview(self.bottomInsetView)
        return stackView
    }()
    
    var topInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    } ()
    
    lazy var connectButtonView: ConnectButtonView = {
       let connectButtonView = ConnectButtonView()
        connectButtonView.defaultConnectButton.addTarget(self, action: #selector(self.connectAction), for: .touchUpInside)
        connectButtonView.qrConnectButton.addTarget(self, action: #selector(self.qrConnectAction), for: .touchUpInside)
        return connectButtonView
    }()
    
    lazy var disconnectButton: BaseButton = {
        let baseButton = BaseButton(
            info: (title: "Disconnect", fontColor: .white),
            backgroundColor: Color.neopinMain
        )
        baseButton.addTarget(self, action: #selector(self.connectAction), for: .touchUpInside)
        return baseButton
    }()
    
    lazy var getAccountButton: BaseButton = {
        let baseButton = BaseButton(
            info: (title: "Get Account", fontColor: .white),
            backgroundColor: Color.neopinMain
        )
        baseButton.addTarget(self, action: #selector(self.getAccountAction), for: .touchUpInside)
        return baseButton
    }()
    
    
    lazy var sendTransactionButton: BaseButton = {
        let baseButton =  BaseButton(
            info: (title: "Send Transaction", fontColor: .white),
            backgroundColor: Color.neopinMain
        )
        baseButton.addTarget(self, action: #selector(self.sendAction), for: .touchUpInside)
        return baseButton
    }()
    
    var bottomInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    } ()
    
    var logTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.cornerRadius = 10
        return textView
    } ()
    
    // MARK: - Initializing
    override init() {
        super.init()
        self.addObserver()
    }
    
    // MARK: - Deinit
    deinit {
        print("\(#function) DEINIT: \(self.className)")
        self.removeObserver()
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - UI
    override func setupConstraints() {
        
        self.infoStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.topInsetView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        
        self.connectButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.disconnectButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.getAccountButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.sendTransactionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.bottomInsetView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        
        self.logTextView.snp.makeConstraints { make in
            make.top.equalTo(self.infoStackView.snp.bottom).offset(20).priority(.low)
//            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
    }
}

private extension MainViewController {
    func setupUI(){
        self.title = "DApp"
        self.view.backgroundColor = .white
        self.view.addSubview(self.infoStackView)
        self.view.addSubview(self.logTextView)
        
        self.reloadInputData()
        self.reloadTextView()
    }
    
    func shownNeedToConnectAlert() {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(
                title: "Need to Connect",
                message: nil,
                preferredStyle: .alert
            )
            let confirmAction = UIAlertAction(title: "Confrim", style: .default)
            alertController.addAction(confirmAction)
            self?.present(alertController, animated: true)
        }
    }
    
    func showQRConnectViewController(){
        DispatchQueue.main.async { [weak self] in
            let qrConnectNaviViewController = UINavigationController(rootViewController: QRConnectViewController())
            self?.present(qrConnectNaviViewController, animated: true)
        }
    }
}

// MARK: - Action
private extension MainViewController {
    @objc func connectAction() {
        print("connectAction")
        
        guard ConnectManager.shared.session == nil else {
            ConnectManager.shared.disconnect()
            return
        }
        
        guard let connectionURL = ConnectManager.shared.connect() else {
            print("Connection Fail")
            return
        }
        
        let deepLinkURL = "examplewallet\(connectionURL)"
        guard let url = URL(string: deepLinkURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func qrConnectAction() {
        self.showQRConnectViewController()
    }
    
    @objc func sendAction() {
        print("sendAction")
        ConnectManager.shared.requestSendTransaction()
        guard (ConnectManager.shared.session?.walletInfo?.approved ?? false),
              let sessionWCURL = ConnectManager.shared.session?.url,
              let url = URL(string: "examplewallet" + sessionWCURL.absoluteString) else {
            self.shownNeedToConnectAlert()
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func getAccountAction() {
        print("getAccountAction")
        
        guard (ConnectManager.shared.session?.walletInfo?.approved ?? false) else {
            self.shownNeedToConnectAlert()
            return
        }
        ConnectManager.shared.getMyAccount()
    }
}
