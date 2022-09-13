//
//  QRConnectViewController.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/08.
//

import UIKit

final class QRConnectViewController: BaseViewController {
    // MARK: UI
    let qrImageView = UIImageView()
    lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect To Neopin", for: .normal)
        button.addTarget(self, action: #selector(self.moveToNeopin), for: .touchUpInside)
        button.setTitleColor(Color.neopinMain, for: .normal)
        return button
    }()
    
    lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy to Clipboard", for: .normal)
        button.addTarget(self, action: #selector(self.copyToClipboardAction), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshConnectURL))
        return barButtonItem
    }()
    
    // MARK: - Properties
    private var qrCodeURL: String?
    
    // MARK: Initializing
    override init() {
        super.init()
        self.addObserver()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinit
    deinit {
        print("\(#function) DEINIT: \(self.className)")
        self.removeObserver()
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        defer { self.qrCodeURL = self.createQRURL() }
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - View Layout
    override func setupConstraints() {
        self.connectButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.qrImageView.snp.top).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        self.qrImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        self.copyButton.snp.makeConstraints { make in
            make.top.equalTo(self.qrImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func cancelButtonDidTap() {
        ConnectManager.shared.disconnect()
        super.cancelButtonDidTap()
    }
}


private extension QRConnectViewController {
    func setupUI() {
        self.title = "QR Connect"
        
        self.view.addSubview(self.connectButton)
        self.view.addSubview(self.qrImageView)
        self.view.addSubview(self.copyButton)
        
        self.navigationItem.rightBarButtonItem = self.rightBarButton
        
        DispatchQueue.main.async { [weak self] in
            guard let qrURLString = self?.qrCodeURL else { return }
            self?.qrImageView.image = QRHelper.createQRImage(from: qrURLString)
        }
    }
    
    func createQRURL() -> String? {
        if ConnectManager.shared.session != nil {
            ConnectManager.shared.disconnect()
        }
        
        guard let connectionURL = ConnectManager.shared.connect() else {
            print("Connection Fail")
            return nil
        }
        
        return "examplewallet" + connectionURL
    }
}

// MARK: - Action
private extension QRConnectViewController {
    @objc func moveToNeopin() {
        self.refreshConnectURL()
        
        guard let qrCodeURL = self.qrCodeURL,
            let url = URL(string: qrCodeURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func copyToClipboardAction() {
        DispatchQueue.main.async { [weak self] in
            UIPasteboard.general.string = self?.qrCodeURL
            
            let alertController = UIAlertController(
                title: nil,
                message: "복사되었습니다.",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(okAction)
            self?.present(alertController, animated: true)
        }
    }
    
    @objc func refreshConnectURL() {
        self.qrCodeURL = self.createQRURL()
        
        DispatchQueue.main.async { [weak self] in
            guard let qrURLString = self?.qrCodeURL else { return }
            self?.qrImageView.image = QRHelper.createQRImage(from: qrURLString)
        }
    }
}

extension QRConnectViewController {
    @objc func reloadInputData() {
        guard let session = ConnectManager.shared.session,
              let approved = session.walletInfo?.approved,
              approved else{ return }
        
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
