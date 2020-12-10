//
//  PreferencesManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 10/12/2020.
//

import UIKit

final class PreferencesManager{
    
    init() {
        
    }
    
    // Returning selected Fiat Symbol
    public func getFiatSymbolName() -> String{
        return UserDefaultsManager.getFiatCurrency()
    }
    
    // returning cryptocurrency value as selected fiat value
    public func getFiatValue(cryptocurrency: Cryptocurrency) -> Double {
        let cryptocurrencyManager: CryptocurrencyManager = CryptocurrencyManager()
        let selectedCurrencySymbol: String = getFiatSymbolName()
        
        return cryptocurrencyManager.getValueAsFiatDouble(value: cryptocurrency.value, fiatSymbol: selectedCurrencySymbol)
    }
    
    // returning fiat value as string
    public func getFiatValueString(cryptocurrency: Cryptocurrency) -> String {
        return String(getFiatValue(cryptocurrency: cryptocurrency))
    }
}
