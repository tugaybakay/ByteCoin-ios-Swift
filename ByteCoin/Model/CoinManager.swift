//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didPriceUpdate(_ coinData: CoinData)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5A0EC7DC-C08B-4610-92AF-738F5355653A"
    var delegate : CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        let url = "\(baseURL)/\(currency)/APIKEY-\(apiKey)"
        performReques(with: url)
    }
    
    private func performReques(with urlString: String){
        if let url = URL(string: urlString){
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, urlRespons , error  in
                if error == nil {
                        if let safeData = data {
                            if let coinData = parseJSON(data: safeData){
                                self.delegate?.didPriceUpdate(coinData)
                            }
                        }
                }else{
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(data:Data) -> CoinData?{
        let decoder = JSONDecoder()
        do{
            let coinData = try decoder.decode(CoinData.self, from: data)
            return coinData
        }catch{
            print("error")
            return nil
        }
    }
}
