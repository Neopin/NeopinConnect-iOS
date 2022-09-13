//
//  QRHelper.swift
//  neopin-connect-iOS-DApp
//
//  Created by Sung9 on 2022/08/08.
//

import UIKit

struct QRHelper {
    static func createQRImage(from string: String) -> UIImage?{
        let data = string.data(using: String.Encoding.ascii)

        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
}
