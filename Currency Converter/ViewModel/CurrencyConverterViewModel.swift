//
//  CurrencyConverterViewModel.swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

class CurrencyConverterViewModel {
    var networkClient = NetworkClient()
    
    
    init() {
    }
    
    func getCurrentRoubleToUSDRate() -> () {
        let currentRate = networkClient.getRoubleToDollarRate()
    }
}
