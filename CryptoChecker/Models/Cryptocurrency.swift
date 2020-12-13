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
            let floatingPoint = ( currencyType == "USD" ? Cryptocurrency.valueFloatingPointFiat : Cryptocurrency.valueFloatingPointBitcoin )
            var returningString = String(format: floatingPoint, setValue)
            if currencyType != "USD" && returningString.last == "0" {
                returningString.removeLast()
                returningString.append("1")
            }
            return returningString
        }
    }
    
    class CurrencyDetailSection: NSObject {
        
        class CurrencyDetail: NSObject {
            var detailTitle: String
//            var detailValue: String
//            var atributedValue: NSAttributedString?
            
            init(detailTitle: String) {
                self.detailTitle = detailTitle
            }
        }
        
        class CurrencyTextDetail: CurrencyDetail {
            var detailValue: String?
            var atributedValue: NSAttributedString?
            
            init(detailTitle: String, detailValue: String? = nil, atributedValue: NSAttributedString? = nil){
                self.detailValue = detailValue
                self.atributedValue = atributedValue
                
                super.init(detailTitle: detailTitle)
            }
            
        }
        
        class CurrencyValueDetail: CurrencyDetail {
            var fiatValue: Double
            var cryptoValue: Double
            
            init(detailTitle: String, fiatValue: Double, cryptoValue: Double){
                self.fiatValue = fiatValue
                self.cryptoValue = cryptoValue
                
                super.init(detailTitle: detailTitle)
            }
            
            public func getFiatValueAsString() -> String{
                return String(format: Cryptocurrency.valueFloatingPointFiat, fiatValue)
            }
            
            public func getCryptoValueAsString() -> String{
                return String(format: Cryptocurrency.valueFloatingPointBitcoin, cryptoValue)
            }
            
        }
        
        var title: String
        var details: [CurrencyDetail]
        
        init(title: String, details: [CurrencyDetail]) {
            self.title = title
            self.details = details
        }
        
    }
    
    var name: String
    var symbolName: String
    var image: UIImage
    var valueFiat: Double
    var value: Double
    var change: Double
    var watchlisted: Bool
    var notifications: [CurrencyNotification]
    var detailSections: [CurrencyDetailSection]
    
    init(name: String, symbolName: String, image: UIImage, valueFiat: Double, valueBitcoin: Double, valueChange: Double, watchlisted: Bool) {
        self.name = name
        self.symbolName = symbolName
        self.image = image
        self.valueFiat = valueFiat
        self.value = valueBitcoin
        self.change = valueChange
        self.watchlisted = watchlisted
        self.notifications = []
        self.detailSections = []
    }
    
    public func update(_ currency: Cryptocurrency){
        self.name = currency.name
        self.symbolName = currency.symbolName
        self.image = currency.image
        self.valueFiat = currency.valueFiat
        self.value = currency.value
        self.change = currency.change
    }
    
    public func getChangeAsString() -> String{
        return String(format: Cryptocurrency.valueChangeFloatingPoint, change)
    }
    
    public func getFiatValueAsString() -> String{
        return String(format: Cryptocurrency.valueFloatingPointFiat, valueFiat)
    }
    
    public func getBitcoinValueAsString() -> String{
        return String(format: Cryptocurrency.valueFloatingPointBitcoin, value)
    }
}
