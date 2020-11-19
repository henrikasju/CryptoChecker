//
//  Cryptocurrency.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Encapsulation?????
class Cryptocurrency: NSObject {
    
    static let valueFloatingPointFiat: String = "%.2f"
    static let valueFloatingPointBitcoin: String = "%.5f"
    static let valueChangeFloatingPoint: String = "%.1f"
    
    class CurrencyNotification: NSObject {
        var setValue: Double
        var aboveValue: Bool
        // TODO: Should be timestamp!
        var date: String
        var isOn: Bool
        // TODO: Should implement some class, that could do conversions!
        var currencyType: String
        
        init(setValue: Double, aboveValue: Bool, creationDate: String, currencyType: String, isOn: Bool = true) {
            self.setValue = setValue
            self.aboveValue = aboveValue
            self.date = creationDate
            self.isOn = isOn
            self.currencyType = currencyType
        }
        
        public func getSetValueAsString() -> String{
            let floatingPoint = ( currencyType == "USD" ? Cryptocurrency.valueFloatingPointFiat : Cryptocurrency.valueChangeFloatingPoint )
            return String(format: floatingPoint, setValue)
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
        return String(format: Cryptocurrency.valueChangeFloatingPoint, change)
    }
    
    public func getFiatValueAsString() -> String{
        return String(format: Cryptocurrency.valueFloatingPointFiat, valueFiat)
    }
    
    public func getBitcoinValueAsString() -> String{
        return String(format: Cryptocurrency.valueFloatingPointBitcoin, valueBitcoin)
    }
}
