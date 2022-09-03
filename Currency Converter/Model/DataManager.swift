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

    func saveRoubleUsdRate() {
        networkClient.getRoubleToDollarRate(completionHandler: { [weak self] rate in
            self?.coreDataManger.saveRate(currencyRateFirstToSecond: rate.0, currencyRateSecondToFirst: rate.1, currencyRatio: .rubUsd)
        })
    }


    func getRoubleUsdRate() -> Double? {
        guard let rate = coreDataManger.getRate(currencyRatio: .rubUsd) else {
            print("core Data error")
            return nil
        }
        return rate
    }

    func getUsdToRoubleRate() -> Double? {
        guard let rate = coreDataManger.getRate(currencyRatio: .usdRub) else {
            print("core Data error")
            return nil
        }
        return rate
    }

}
