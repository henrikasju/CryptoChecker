//
//  DataBaseManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

// TODO: Fix almost everything
final class DataBaseManager{
    
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
    
    private var dataWatchlisted: [Cryptocurrency] = []
    
    public static let shareInstance: DataBaseManager = {
        let instance = DataBaseManager()
        
        return instance
    }()
    
    public func fetchCryptocurrencies() -> [Cryptocurrency]{
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
    
    public func updateData(_ old: Cryptocurrency, to: Cryptocurrency){
        let index: Int = data.firstIndex(of: old)!
        
        data[index] = to
    }
    
    
    
    
}
