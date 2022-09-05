//
//  CurrencyConverterViewModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

class CurrencyConverterViewModel {
    var dataManager = DataManager()
    var currentFirstCurrency: Currency = .RUB
    var currentSecondCurrecny: Currency = .USD

    init() {
        dataManager.saveFirstCurrencyRateToDB(firstCurrency: currentFirstCurrency, secondCurrency: currentSecondCurrecny)
    }

    func getExchangeResultAmountString(from: Currency,
                                       to: Currency,
                                       currencyAmount: Double) -> String {
        let rate = getExchangeRate(currencyFrom: from, currencyTo: to)
        let resultNumber = rate * currencyAmount
        let resultString = String(format: "%.2f", resultNumber)
        return resultString
    }

    func updateCurrencyRate() {
        dataManager.getCurrencyRateFromServer(firstCurrency: currentFirstCurrency , secondCurrency: currentSecondCurrecny)
    }

    private func getExchangeRate(currencyFrom: Currency, currencyTo: Currency) -> Double {
        return dataManager.getFirstToSecondCurrencyRate(firstCurrency: currentFirstCurrency, secondCurrency: currentSecondCurrecny) ?? 0
    }
    

}
