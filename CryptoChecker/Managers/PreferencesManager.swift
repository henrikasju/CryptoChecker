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
    
    let cryptocurrencyManager: CryptocurrencyManager
    
    init() {
        fiatSymbols = [:]
        
        fiatSymbols["USD"] = "$"
        fiatSymbols["Euro"] = "€"
        fiatSymbols["Yen"] = "¥"
        
        cryptocurrencyManager = CryptocurrencyManager()
    }
    
    // Returning selected Fiat Symbol
    public func getFiatName() -> String {
        return UserDefaultsManager.getFiatCurrency()
    }
    
    // Getting fiat symbol from fiat name
    public func getFiatSymbol(fiatName: String? = nil) -> String {
        var setfiatName: String = ""
        if fiatName == nil {
            setfiatName = self.getFiatName()
        }else{
            setfiatName = fiatName!
        }
        
        // Checking if requested fiat symbol exist
        if fiatSymbols.keys.contains(setfiatName) {
            return fiatSymbols[setfiatName]!
        // If symbols does not exist, returning USD symbol
        }else{
            return fiatSymbols["USD"] ?? "$"
        }
    }
    
    // returning cryptocurrency value as selected fiat value
    public func getValueAsSelectedFiat(value: Double) -> Double {
        let selectedCurrencySymbol: String = getFiatName()
        
        return cryptocurrencyManager.getValueAsFiatDouble(value: value, fiatName: selectedCurrencySymbol)
    }
    
    // returning selected fiat value as string
    public func getValueAsSelectedFiatString(value: Double) -> String {
        return String(format: valueFloatingPointFiat, getValueAsSelectedFiat(value: value))
    }
    
    // returning cryptocurrency value as String
    public func getFormatedSetCryptoValueString(value: Double) -> String {
        return String(format: valueFloatingPointBitcoin, value)
    }
    
    // returning formated fiat value
    public func getFormatedFiatValue(value: Double) -> String {
        return String(format: valueFloatingPointFiat, value)
    }
    
}
