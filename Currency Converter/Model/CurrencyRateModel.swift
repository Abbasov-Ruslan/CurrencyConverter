//
//  CurrencyRateModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

enum Currency: String, CaseIterable {
    case RUB
    case USD
    case EUR
}

public class CurrencyNetworkModel: Decodable {
    let status: Int
    let message: String
    let data: [String: String]

    init(status: Int, message: String, data: String) {
        self.status = status
        self.message = message
        self.data = convertToDictionary(text: data) ?? [:]
    }
}

func convertToDictionary(text: String) -> [String: String]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
