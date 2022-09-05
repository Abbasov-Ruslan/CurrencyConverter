//
//  DataManager.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 02.09.2022.
//

import Foundation
import CoreData

class DataManager {
    var networkClient = NetworkManager()
    var coreDataManger = CoreDataManager()

    func saveFirstCurrencyRateToDB(firstCurrency: Currency, secondCurrency: Currency) {
//        if !coreDataManger.isDatabaseHaveCash() {
            self.coreDataManger.clearCurrencyDataBase()
//        }
        saveCurrencyRateToDB(firstCurrency: firstCurrency, secondCurrency: secondCurrency)
    }

    func getCurrencyRateFromServer(firstCurrency: Currency, secondCurrency: Currency) {
        
        saveFirstCurrencyRateToDB(firstCurrency: firstCurrency, secondCurrency: secondCurrency)
    }

    func getFirstToSecondCurrencyRate(firstCurrency: Currency, secondCurrency: Currency) -> Double?  {
        guard let rate = coreDataManger.getRate(firstCurrency: firstCurrency, secondCurrency: secondCurrency) else {
            print("core Data error")
            return nil
        }
        return rate
    }


    private func saveCurrencyRateToDB(firstCurrency: Currency, secondCurrency: Currency) {
        networkClient.getCurrencyRate(firstCurrency: firstCurrency, secondCurrency: secondCurrency,completionHandler: { [weak self] rate in
            let firstToSecondDouble = Double(rate.0) ?? 0
            let secondToFirtstDouble = Double(rate.1) ?? 0
            self?.coreDataManger.saveRate(currencyRateFirstToSecond: firstToSecondDouble, currencyRateSecondToFirst: secondToFirtstDouble, currencyNameFirst: firstCurrency, currencyNameSecond: secondCurrency)
        })
    }

}
