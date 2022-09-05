//
//  NetworkClient..swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

public class NetworkManager {
    var apiClient = ApiClient()

    //    func getCurrencyRate(firstCurrency: Currency, secondCurrency: Currency, completionHandler:@escaping ((Double, Double)) -> Void) {
    //        ApiClient.getJsonCurrencyRate(firstCurrency: firstCurrency, secondCurrency: secondCurrency, completionHandler: { data in
    //            guard let firstToSecond = data?.data., let usdRub = data?.data.secondCurrency else {
    //                return
    //            }
    //            guard let intRubUSD = Double(firstToSecond), let intUsdRub = Double(usdRub) else {
    //                return
    //            }
    //            completionHandler((firstToSecond, usdToRouble))
    //        })
    //    }

    func getCurrencyRate(firstCurrency: Currency, secondCurrency: Currency, completionHandler:@escaping ((String, String)) -> Void) {
        ApiClient.getJsonCurrencyRate(firstCurrency: firstCurrency, secondCurrency: secondCurrency, completionHandler: { data in
            guard let firstToSecond = data?.data[firstCurrency.rawValue + secondCurrency.rawValue],
                  let secondToFirst = data?.data[secondCurrency.rawValue + firstCurrency.rawValue]
            else {
                return
            }
            completionHandler((firstToSecond, secondToFirst))
        })
    }

}

    struct ApiClient {

        static func getJsonCurrencyRate(firstCurrency: Currency, secondCurrency: Currency, completionHandler: @escaping (CurrencyNetworkModel?) -> Void) {

            let jsonUrlString = "https://currate.ru/api/?get=rates&pairs=" + firstCurrency.rawValue + secondCurrency.rawValue + "," + secondCurrency.rawValue + firstCurrency.rawValue + "&key=5b98e6d9e079a12e25af7f9aeed9e738"

            guard let url = URL(string: jsonUrlString) else {
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in

                guard let data = data, error == nil else {
                    print(error!.localizedDescription)
                    return
                }

                do {
                    let response: CurrencyNetworkModel = try JSONDecoder().decode(CurrencyNetworkModel.self, from: data)
                    completionHandler(response)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            }.resume()
        }
    }
