//
//  ConnectButtonView.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/05.
//

import Foundation
import UIKit

final class ConnectButtonView: BaseView {
    // MARK: - UI
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(self.defaultConnectButton)
        stackView.addArrangedSubview(self.qrConnectButton)
        return stackView
    } ()
    
    let defaultConnectButton = BaseButton(
        info: (title: "Connect", fontColor: .white),
        backgroundColor: UIColor(red: 26/255, green: 183/255, blue: 235/255, alpha: 1)
    )
    
    let qrConnectButton = BaseButton(
        info: (title: "QR Connect", fontColor: .white),
        backgroundColor: UIColor(red: 26/255, green: 183/255, blue: 235/255, alpha: 1)
    )
    
    // MARK: - Initializing
    init() {
        super.init(frame: .zero)
        self.addSubview(self.buttonStackView)
        self.setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ConnectButtonView {
    func setupConstraints() {
        self.buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.defaultConnectButton.snp.makeConstraints { make in
            make.width.equalTo(self.qrConnectButton.snp.width)
        }
    }
}
