//
//  ResponseApi.swift
//  ByteCoin
//
//  Created by Arilson Silva on 28/07/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation
struct APIResponse: Decodable {
    
    //To-do ajustar BTCBRL pois está chamando somente um tipo
    let BTCBRL: CoinData
}
