//
//  Cryptocurrency.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Encapsulation?????
class Cryptocurrency: NSObject {
    
    class CurrencyNotification: NSObject {
        var setValue: Double
        var aboveValue: Bool
        // TODO: Should be timestamp!
        var date: String
        var isOn: Bool
        // TODO: Should implement some class, that could do conversions!
        var currencyType: String
        
        init(setValue: Double, aboveValue: Bool, creationDate: String, currencyType: String) {
            self.setValue = setValue
            self.aboveValue = aboveValue
            self.date = creationDate
            self.isOn = true
            self.currencyType = currencyType
        }
    }
    
    var name: String
    var symbolName: String
    var image: UIImage
    var valueFiat: Double
    var valueBitcoin: Double
    var change: Double
    var watchlisted: Bool
    var notifications: [CurrencyNotification]
    
    let valueFloatingPointFiat: String = "%.2f"
    let valueFloatingPointBitcoin: String = "%.5f"
    let valueChangeFloatingPoint: String = "%.1f"
    
    init(name: String, symbolName: String, image: UIImage, valueFiat: Double, valueBitcoin: Double, valueChange: Double, watchlisted: Bool) {
        self.name = name
        self.symbolName = symbolName
        self.image = image
        self.valueFiat = valueFiat
        self.valueBitcoin = valueBitcoin
        self.change = valueChange
        self.watchlisted = watchlisted
        self.notifications = []
    }
    
    public func update(_ currency: Cryptocurrency){
        self.name = currency.name
        self.symbolName = currency.symbolName
        self.image = currency.image
        self.valueFiat = currency.valueFiat
        self.valueBitcoin = currency.valueBitcoin
        self.change = currency.change
    }
    
    public func getChangeAsString() -> String{
        return String(format: valueChangeFloatingPoint, change)
    }
    
    public func getFiatValueAsString() -> String{
        return String(format: valueFloatingPointFiat, valueFiat)
    }
    
    public func getBitcoinValueAsString() -> String{
        return String(format: valueFloatingPointBitcoin, valueBitcoin)
    }
}
