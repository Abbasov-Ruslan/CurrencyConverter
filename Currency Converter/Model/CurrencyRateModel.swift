//
//  CurrencyRateModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

public class CurrencyNetworkModel: Codable {
    let status: Int
    let message: String
    let data: DataClass

    init(status: Int, message: String, data: DataClass) {
        self.status = status
        self.message = message
        self.data = data
    }
}

public class DataClass: Codable {
    let rubusd, usdrub: String

    enum CodingKeys: String, CodingKey {
        case rubusd = "RUBUSD"
        case usdrub = "USDRUB"
    }

    init(rubusd: String, usdrub: String) {
        self.rubusd = rubusd
        self.usdrub = usdrub
    }
}
