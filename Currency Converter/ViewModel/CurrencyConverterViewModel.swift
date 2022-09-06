//
//  CurrencyConverterViewModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

class CurrencyConverterViewModel {
    var dataManager = DataManager()
    var currentCurrencyForChange: ExchnageDirection = .leftToRight
    var currentFirstCurrency: Currency = .USD
    var currentSecondCurrecny: Currency = .RUB
    var timePeriodForUpdate: TimeInterval = 900
    var updateTimer = Timer()

    init() {
        dataManager.saveFirstCurrencyRateToDB(firstCurrency: currentFirstCurrency, secondCurrency: currentSecondCurrecny)

        scheduledTimerWithTimeInterval(timeInterval: timePeriodForUpdate)
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
        dataManager.getCurrencyRateFromServer(firstCurrency: currentFirstCurrency, secondCurrency: currentSecondCurrecny)
    }

    private func getExchangeRate(currencyFrom: Currency, currencyTo: Currency) -> Double {
        return dataManager.getFirstToSecondCurrencyRate(firstCurrency: currentFirstCurrency, secondCurrency: currentSecondCurrecny) ?? 0
    }

    func restartTimer(timeInterval: TimeInterval) {
        updateTimer.invalidate()
        scheduledTimerWithTimeInterval(timeInterval: timeInterval)
    }

    private func scheduledTimerWithTimeInterval(timeInterval: TimeInterval) {
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        updateTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting() {
        updateCurrencyRate()
    }
}
