//
//  PreferencesManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 10/12/2020.
//

import UIKit

final class PreferencesManager{
    
    let valueFloatingPointFiat: String = "%.2f"
    let valueFloatingPointBitcoin: String = "%.5f"
    let valueChangeFloatingPoint: String = "%.1f"
    
    var fiatSymbols: [String: String]
    
    init() {
        fiatSymbols = [:]
        
        fiatSymbols["USD"] = "$"
        fiatSymbols["Euro"] = "€"
        fiatSymbols["Yen"] = "¥"
    }
    
    // Returning selected Fiat Symbol
    public func getFiatName() -> String {
        return UserDefaultsManager.getFiatCurrency()
    }
    
    // Getting fiat symbol from fiat name
    public func getFiatSymbol() -> String {
        let fiatName = self.getFiatName()
        // Checking if requested fiat symbol exist
        if fiatSymbols.keys.contains(fiatName) {
            return fiatSymbols[fiatName]!
        // If symbols does not exist, returning USD symbol
        }else{
            return fiatSymbols["USD"] ?? "$"
        }
    }
    
    // returning cryptocurrency value as selected fiat value
    public func getFiatValue(cryptocurrency: Cryptocurrency) -> Double {
        let cryptocurrencyManager: CryptocurrencyManager = CryptocurrencyManager()
        let selectedCurrencySymbol: String = getFiatName()
        
        return cryptocurrencyManager.getValueAsFiatDouble(value: cryptocurrency.valueFiat, fiatName: selectedCurrencySymbol)
    }
    
    // returning fiat value as string
    public func getFiatValueString(cryptocurrency: Cryptocurrency) -> String {
        return String(format: valueFloatingPointFiat ,getFiatValue(cryptocurrency: cryptocurrency))
    }
}
