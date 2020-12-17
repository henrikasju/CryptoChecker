//
//  DataBaseManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Fix almost everything
final class DataBaseManager{
    
    private var detailSections: [Cryptocurrency.CurrencyDetailSection] = {
        let details1: [Cryptocurrency.CurrencyDetailSection.CurrencyDetail] = [
            Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail(detailTitle: "Open", fiatValue: 312.22, cryptoValue: 0.10),
            Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail(detailTitle: "Close", fiatValue: 312.22, cryptoValue: 0.10),
            Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail(detailTitle: "High", fiatValue: 312.25, cryptoValue: 0.1001),
            Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail(detailTitle: "Low", fiatValue: 312.21, cryptoValue: 0.09999),
            Cryptocurrency.CurrencyDetailSection.CurrencyValueDetail(detailTitle: "Average", fiatValue: 312.23, cryptoValue: 0.10001),
            Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail(detailTitle: "Change", detailValue: nil, atributedValue: NSAttributedString(string: "0.7%"))
        ]
        let detailSection1 = Cryptocurrency.CurrencyDetailSection(title: "Price", details: details1)
        
        let details2: [Cryptocurrency.CurrencyDetailSection.CurrencyDetail] = [
            Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail(detailTitle: "Market Cap", detailValue: "44.64 Bn", atributedValue: nil),
            Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail(detailTitle: "Circulating", detailValue: "113.17 M", atributedValue: nil),
            Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail(detailTitle: "Max Supply", detailValue: "N/A", atributedValue: nil),
            Cryptocurrency.CurrencyDetailSection.CurrencyTextDetail(detailTitle: "Rank", detailValue: "2", atributedValue: nil)
        ]
        let detailSection2 = Cryptocurrency.CurrencyDetailSection(title: "Market Stats", details: details2)
        
        return [detailSection1, detailSection2]
    }()
    
    private var data: [Cryptocurrency] = [
        Cryptocurrency(name: "Bitcoin", symbolName: "BTC", image: #imageLiteral(resourceName: "btc"), valueFiat: 20031.23, valueBitcoin: 1, valueChange: 2.3, watchlisted: false),
        Cryptocurrency(name: "Ethereum", symbolName: "ETC", image: #imageLiteral(resourceName: "etc"), valueFiat: 312.23, valueBitcoin: 0.1, valueChange: 0.7, watchlisted: true),
        Cryptocurrency(name: "Tether", symbolName: "USDT", image: #imageLiteral(resourceName: "usdt"), valueFiat: 0.98, valueBitcoin: 0.00003, valueChange: -0.1, watchlisted: true),
        Cryptocurrency(name: "XRP", symbolName: "XRP", image: #imageLiteral(resourceName: "xrp"), valueFiat: 0.25, valueBitcoin: 0.00001, valueChange: 0.1, watchlisted: false),
        Cryptocurrency(name: "Bitcoin Cash", symbolName: "BCH", image: #imageLiteral(resourceName: "bch"), valueFiat: 258.79, valueBitcoin: 0.07, valueChange: -1.2, watchlisted: false),
        Cryptocurrency(name: "Chainlink", symbolName: "LINK", image: #imageLiteral(resourceName: "link"), valueFiat: 11.72, valueBitcoin: 0.0001, valueChange: 0.7, watchlisted: true),
        Cryptocurrency(name: "Binance Coin", symbolName: "BNB", image: #imageLiteral(resourceName: "bnb"), valueFiat: 31.42, valueBitcoin: 0.00019, valueChange: 0.3, watchlisted: false),
        Cryptocurrency(name: "Polkadot", symbolName: "DOT", image: #imageLiteral(resourceName: "dot"), valueFiat: 4.89, valueBitcoin: 0.00006, valueChange: 0.2, watchlisted: true),
        Cryptocurrency(name: "Litecoin", symbolName: "LTC", image: #imageLiteral(resourceName: "ltc"), valueFiat: 56.37, valueBitcoin: 0.00023, valueChange: 0.1, watchlisted: false),
    ]
    
    private init() {
        print("Fake DataBase created!")
        
        // Adding fake notifications!
        data[1].notifications = [
            Cryptocurrency.CurrencyNotification(setValue: 304.99, aboveValue: false, creationDate: "2020-09-12", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 320.00, aboveValue: true, creationDate: "2020-05-27", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 307.11, aboveValue: false, creationDate: "2020-02-12", currencyType: "USD", isOn: false),
            Cryptocurrency.CurrencyNotification(setValue: 299.50, aboveValue: false, creationDate: "2020-01-22", currencyType: "USD", isOn: false),
        ]
        
        data[2].notifications = [
            Cryptocurrency.CurrencyNotification(setValue: 1.00, aboveValue: true, creationDate: "2020-07-16", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 0.98, aboveValue: false, creationDate: "2020-06-10", currencyType: "USD", isOn: true),
        ]
        
        data[5].notifications = [
            Cryptocurrency.CurrencyNotification(setValue: 9.50, aboveValue: false, creationDate: "2020-02-12", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 21.10, aboveValue: true, creationDate: "2020-12-03", currencyType: "USD", isOn: true),
        ]
        
        data[7].notifications = [
            Cryptocurrency.CurrencyNotification(setValue: 5.12, aboveValue: true, creationDate: "2019-10-18", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 4.60, aboveValue: false, creationDate: "2020-08-08", currencyType: "USD", isOn: false),
            Cryptocurrency.CurrencyNotification(setValue: 10, aboveValue: true, creationDate: "2019-01-07", currencyType: "USD", isOn: true),
            Cryptocurrency.CurrencyNotification(setValue: 3, aboveValue: false, creationDate: "2020-04-04", currencyType: "USD", isOn: false),
        ]
    }
    
    private var dataWatchlisted: [Cryptocurrency] = []
    
    public static let shareInstance: DataBaseManager = {
        let instance = DataBaseManager()
        
        return instance
    }()
    
    public func fetchCryptocurrencies() -> [Cryptocurrency]{
        for currency in data {
            currency.detailSections = detailSections
        }
        return data
    }
    
    public func fetchWatchlistedCryptocurrencies() -> [Cryptocurrency]{
        var returnData: [Cryptocurrency] = []
        for currency in data {
            if currency.watchlisted {
                returnData.append(currency)
            }
        }
        
        return returnData
    }
    
    public func fetchCryptocurrenciesWithNotifications() -> [Cryptocurrency]{
        var returnData: [Cryptocurrency] = []
        for currency in data {
            if currency.notifications.count > 0 {
                returnData.append(currency)
            }
        }
        
        return returnData
    }
    
    public func updateData(_ old: Cryptocurrency, to: Cryptocurrency){
        if let index: Int = data.firstIndex(of: old){
            data[index] = to
        }else{
            fatalError("Error: Could not access data!")
        }
    }
    
    
    
    
}
