//
//  CryptocurrencyManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 10/12/2020.
//

import UIKit

class CryptocurrencyManager {

    var conversionRates: [String: Double]
    var fiatSymbols: [String: String]
    
    init() {
        conversionRates = [:]
        fiatSymbols = [:]
        
        conversionRates["USD"] = 1.0
        conversionRates["Euro"] = 0.82
        conversionRates["Yen"] = 104.31
    }
    
    // Converting cryptocurrency value from USD to selected Fiat currency
    public func getValueAsFiatDouble(value: Double, fiatName: String) -> Double{
        var returnResult: Double = value
        
        // Checking if requested fiat is available
        if conversionRates.keys.contains(fiatName) {
            returnResult *= conversionRates[fiatName]!
        
        // Unknown requested fiat, returning as USD
        }else{
            returnResult *= conversionRates["USD"] ?? 1.0
        }
        
        return returnResult
    }

}
