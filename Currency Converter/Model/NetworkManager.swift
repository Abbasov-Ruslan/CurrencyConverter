//
//  NetworkClient..swift
//  Currency Converter
//
//  Created by Ruslan Abbasov on 01.09.2022.
//

import Foundation

public class NetworkManager {
    var apiClient = ApiClient()

    public func getRoubleToDollarRate(completionHandler:@escaping ((Double, Double)) -> Void) {
        var roubleToUsd: Double = 0
        var usdToRouble: Double = 0
        ApiClient.getJson(completionHandler: { (data) in
            guard let rubUsd = data?.data.rubusd, let usdRub = data?.data.usdrub else {
                return
            }
            guard let intRubUSD = Double(rubUsd), let intUsdRub = Double(usdRub) else {
                return
            }
            roubleToUsd = intRubUSD
            usdToRouble = intUsdRub
            completionHandler((roubleToUsd, usdToRouble))
        })
    }

}

struct ApiClient {

    static func getJson(completionHandler: @escaping (CurrencyNetworkModel?) -> Void) {

        let jsonUrlString = "https://currate.ru/api/?get=rates&pairs=RUBUSD,USDRUB&key=5b98e6d9e079a12e25af7f9aeed9e738"

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
