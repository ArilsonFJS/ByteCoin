//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinServiceDelegate {
    func didUpdatePrice(price: String, currency: String)
        func didFailWithError(error: Error)
}

class Service {
    
    let baseURL = "https://economia.awesomeapi.com.br/json/last/BTC-" //"https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "02d16eb7f261d02d00f5bfdd13651773797b3fae909beca5846bf9790f1ac58a"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinServiceDelegate?
    
    func performRequest(urlString: String) {
        
    }
    
    func fetchCoin(for currency: String) {
        let urlString = "\(baseURL)\(currency)?token=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                self.delegate?.didFailWithError(error: error!)
            }
            
            if let safeData = data {
                if let bitcoinPrice = self.parseJson(safeData) {
                    let priceString = String(format: "%.2f", bitcoinPrice)
                    self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                }
            }
        }.resume()
        //performRequest(urlString: url)
    }
    
    func parseJson(_ coinData: Data) -> String? {
        let jsonDecoder = JSONDecoder()
        let json = String(data: coinData, encoding: .utf8)
        print("DADOS RETORNADOS DA API: \(json)")
        do {
            let decodeData = try jsonDecoder.decode(APIResponse.self, from: coinData)
            let lastPrice = decodeData.BTCBRL.bid
            print(lastPrice)
            return lastPrice
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
