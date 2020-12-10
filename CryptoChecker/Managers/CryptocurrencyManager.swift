//
//  CryptocurrencyManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 10/12/2020.
//

import UIKit

class CryptocurrencyManager {
    
    let valueFloatingPointFiat: String = "%.2f"
    let valueFloatingPointBitcoin: String = "%.5f"
    let valueChangeFloatingPoint: String = "%.1f"
    
    var conversionRates: [String: Double]
    
    init() {
        conversionRates = [:]
        
        conversionRates["USD"] = 1.0
        conversionRates["Euro"] = 0.82
        conversionRates["Yen"] = 104.31
    }
    
    // Converting cryptocurrency value from USD to selected Fiat currency
    public func getValueAsFiatDouble(value: Double, fiatSymbol: String) -> Double{
        var returnResult: Double = value
        
        // Checking if requested fiat is available
        if conversionRates.keys.contains(fiatSymbol) {
            returnResult *= conversionRates[fiatSymbol]!
        
        // Unknown requested fiat, returning as USD
        }else{
            returnResult *= conversionRates["USD"] ?? 1.0
        }
        
        return returnResult
    }
}
