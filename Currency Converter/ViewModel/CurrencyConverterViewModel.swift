//
//  CurrencyConverterViewModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

class CurrencyConverterViewModel {
    var dataManager = DataManager()

    init() {
        dataManager.saveRoubleUsdRate()
    }

    func getCurrentRoubleToUSDRate() -> Double {
        return dataManager.getRoubleUsdRate() ?? 0
    }

    func getCurrentUsdToRoubleRate() -> Double {
        return dataManager.getUsdToRoubleRate() ?? 0
    }
}
