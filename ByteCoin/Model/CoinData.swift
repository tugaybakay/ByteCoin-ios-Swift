//
//  CoinData.swift
//  ByteCoin
//
//  Created by MacOS on 6.08.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable{
    let rate: Double
    let asset_id_quote: String
}
