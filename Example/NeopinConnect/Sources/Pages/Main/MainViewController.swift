//
//  MainViewController.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/02.
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
        stackView.addArrangedSubview(self.userButtonView)
        stackView.addArrangedSubview(self.klaytnSendTransactionButton)
        stackView.addArrangedSubview(self.polygonSendTransactionButton)
        stackView.addArrangedSubview(self.bottomInsetView)
        return stackView
    }()
    
    var topInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    } ()
    
    lazy var connectButtonView: MultipleButtonView = {
        let connectButtonView = MultipleButtonView(titles: ["Connect", "QR Connect"])
        if let connectButton = connectButtonView.buttonStackView.arrangedSubviews.first as? BaseButton {
            connectButton.addTarget(self, action: #selector(self.connectAction), for: .touchUpInside)
        }
        
        if let qrConnectButton = connectButtonView.buttonStackView.arrangedSubviews.last as? BaseButton {
            qrConnectButton.addTarget(self, action: #selector(self.qrConnectAction), for: .touchUpInside)
        }
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
    
    lazy var userButtonView: MultipleButtonView = {
        let userButtonView = MultipleButtonView(titles: ["Get Account", "PersonalSign"])
        if let getAccountButton = userButtonView.buttonStackView.arrangedSubviews.first as? BaseButton {
            getAccountButton.addTarget(self, action: #selector(self.getAccountAction), for: .touchUpInside)
        }
        
        if let personalSigntButton = userButtonView.buttonStackView.arrangedSubviews.last as? BaseButton {
            personalSigntButton.addTarget(self, action: #selector(self.requestPersonalSign), for: .touchUpInside)
        }
        return userButtonView
    }()
    
    
    lazy var klaytnSendTransactionButton: BaseButton = {
        let baseButton =  BaseButton(
            info: (title: "Klaytn Send Transaction", fontColor: .white),
            backgroundColor: Color.neopinMain
        )
        baseButton.addTarget(self, action: #selector(self.requestKlaytnSendTransaction), for: .touchUpInside)
        return baseButton
    }()
    
    lazy var polygonSendTransactionButton: BaseButton = {
        let baseButton =  BaseButton(
            info: (title: "Polygon Send Transaction", fontColor: .white),
            backgroundColor: Color.neopinMain
        )
        baseButton.addTarget(self, action: #selector(self.requestPolygonSendTransaction), for: .touchUpInside)
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
        
        self.userButtonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.klaytnSendTransactionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.polygonSendTransactionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        self.bottomInsetView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        
        self.logTextView.snp.makeConstraints { make in
            make.top.equalTo(self.infoStackView.snp.bottom).offset(20).priority(.low)
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
        
        let deepLinkURL = "npt\(connectionURL)"
        guard let url = URL(string: deepLinkURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func qrConnectAction() {
        self.showQRConnectViewController()
    }
    
    @objc func requestKlaytnSendTransaction() {
        print("requestSendTransaction")
        ConnectManager.shared.requestSendTransaction(chain: .klay)
        guard (ConnectManager.shared.session?.walletInfo?.approved ?? false),
              let sessionWCURL = ConnectManager.shared.session?.url,
              let url = URL(string: "npt" + sessionWCURL.absoluteString) else {
            self.shownNeedToConnectAlert()
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func requestPolygonSendTransaction() {
        print("requestSendTransaction")
        ConnectManager.shared.requestSendTransaction(chain: .polygon)
        guard (ConnectManager.shared.session?.walletInfo?.approved ?? false),
              let sessionWCURL = ConnectManager.shared.session?.url,
              let url = URL(string: "npt" + sessionWCURL.absoluteString) else {
            self.shownNeedToConnectAlert()
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func requestPersonalSign() {
        print("requestPersonalSign")
        ConnectManager.shared.requestPersonalSign()
        guard (ConnectManager.shared.session?.walletInfo?.approved ?? false),
              let sessionWCURL = ConnectManager.shared.session?.url,
              let url = URL(string: "npt" + sessionWCURL.absoluteString) else {
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
