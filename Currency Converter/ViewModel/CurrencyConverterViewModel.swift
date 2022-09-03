//
//  CurrencyConverterViewModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

enum CurrencyName {
    case dollar
    case euro
    case rouble
}

import Foundation

class CurrencyConverterViewModel {
    var dataManager = DataManager()

    init() {
        dataManager.saveRoubleUsdRate()
    }

    func getExchangeResultAmountString(from: CurrencyName,
                                       to: CurrencyName,
                                       currencyAmount: Double) -> String {
        let rate = getExchangeRate(currencyFrom: from, currencyTo: to)
        let resultNumber = rate * currencyAmount
        let resultString = String(format: "%.2f", resultNumber)
        return resultString
    }

    private func getExchangeRate(currencyFrom: CurrencyName, currencyTo: CurrencyName) -> Double {
        switch (currencyFrom, currencyTo) {
        case (.rouble, .dollar):
            return dataManager.getRoubleUsdRate() ?? 0
        case (.dollar, .rouble):
            return dataManager.getUsdToRoubleRate() ?? 0
        default:
            return 0
        }
    }

}
