//
//  ABIHelper.swift
//  neopin-connect-iOS-DApp
//
//  Created by Neopin on 2022/08/17.
//
import web3swift

struct ABIHelper {
    static func encode(
        param: [AnyObject]?,
        function: ABI.Element.Function?
    ) -> String? {
        guard let param = param else { return nil }
        guard let function = function else { return nil }
        let object = ABI.Element.function(function)
        guard let encodedData = object.encodeParameters(param) else { return nil }
        return "0x" + encodedData.toHexString()
    }
    
    static func decodedABIInfo(data: String?) {
        guard let decodeData = ABIHelper.decodeABIData(data: data, function: ABIHelper.getTransferFunction()) else {
            print("\(#function) ABIHelper.decodeABIData error")
            return
        }
        
        print("decodedData: \(decodeData)")
    }
}


// MARK: - Decode
private extension ABIHelper {
    static func decodeABIData(
        data: String?,
        function: ABI.Element.Function?
    ) -> [String: Any]? {
        guard let data = data else { return nil }
        guard let function = function else { return nil }
        let object = ABI.Element.function(function)
        return object.decodeInputData(data.withoutHex.hex)
    }
}

// MARK: - Function
extension ABIHelper {
    static func increaseAllowanceFunction() -> ABI.Element.Function {
        return ABI.Element.Function(
            name: "increaseAllowance",
            inputs: [
                .init(name: "address", type: .address),
                .init(name: "value", type: .uint(bits: 256))
            ],
            outputs: [],
            constant: false,
            payable: false
        )
    }
    
    static func getTransferFunction() -> ABI.Element.Function{
        return ABI.Element.Function(
            name: "transfer",
            inputs: [
                .init(name: "address", type: .address),
                .init(name: "value", type: .uint(bits: 256))
            ],
            outputs: [],
            constant: false,
            payable: false
        )
    }
}

