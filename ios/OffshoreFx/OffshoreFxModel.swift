//
//  OffshoreFxModel.swift
//  Runner
//
//  Created by Saulo Nascimento on 17/01/26.
//

import Foundation

public struct OffshoreFxModel {
    public let accountNumber: String

    
    public init(accountNumber: String) {
        self.accountNumber = accountNumber
    }

    public static func fromMap(_ map: [String: Any]?) -> OffshoreFxModel? {
        guard let map = map else { return nil }
        
        return OffshoreFxModel(
            accountNumber: map["accountNumber"] as? String ?? ""
        )
    }
}
