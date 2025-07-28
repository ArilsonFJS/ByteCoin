//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Service {
    
    let baseURL = "https://economia.awesomeapi.com.br/json/last/BTC-" //"https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "SUA_APIKEY"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            if let safeData = data {
                let json = String(data: safeData, encoding: .utf8)
                print(json)
            }
        }.resume()
    }
    
    func fetchCoin(for currency: String) {
        let url = "\(baseURL)\(currency)?token=\(apiKey)"
        print(url)
        performRequest(urlString: url)
    }
    
    func parseJson(_ coinData: Data) -> CoinModel? {
        let jsonDecoder = JSONDecoder()
        
        do {
            let decodeData = try jsonDecoder.decode(CoinData.self, from: coinData)
            let target = decodeData.code
            let source = decodeData.codeIn
            let value = decodeData.bid
            let coin = CoinModel(targetCurrency: target, sourceCurrency: source, rate: value)
            return coin
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
