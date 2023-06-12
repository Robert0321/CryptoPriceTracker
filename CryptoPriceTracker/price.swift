//
//  price.swift
//  CryptoPriceTracker
//
//  Created by LI,JYUN-SIAN on 12/6/23.
//

import Foundation

// 自訂解碼型別
struct Price: Codable {
    
    let name: String
    let unit: String
    let value: Float
    let type: String
}

// 保存價格
struct Currency: Codable {
    
    let btc: Price
    let eth: Price
    let aud: Price
    let usd: Price
}

//當前利率價格
struct Rates: Codable {
    
    let rates: Currency
}


