//
//  PreferencesManager.swift
//  CryptoChecker
//
//  Created by Henrikas J on 10/12/2020.
//

import UIKit

final class UserDefaultsManager {
    
    private static let defaults = UserDefaults.standard
    
    public static func getAlreadyLaunchedStatus() -> Bool {
        let returnBool = defaults.bool(forKey: Constants.UserDefaults.alreadyLaunched.key)
        return returnBool
    }
    
    // Returning global notificatino status from User defaults
    public static func getUserGlobalNotificationStatus() -> Bool {
        let returnBool = defaults.bool(forKey: Constants.UserDefaults.globalNotificationStatus.key)
        return returnBool
    }
    
    // Returning selected date format from User defaults
    public static func getDateFormat() -> String {
        let returnString: String = defaults.string(forKey: Constants.UserDefaults.dataFormat.key)
                                   ?? Constants.UserDefaults.dataFormat.defaultValue
        
        return returnString
    }
    
    // Returning selected time format from User defaults
    public static func getTimeFormat() -> String {
        let returnString: String = defaults.string(forKey: Constants.UserDefaults.timeFormat.key)
                                   ?? Constants.UserDefaults.timeFormat.defaultValue
        
        return returnString
    }
    
    // Returning selected date format from User defaults
    public static func getFiatCurrency() -> String {
        let returnString: String = defaults.string(forKey: Constants.UserDefaults.dataFormat.key)
                                   ?? Constants.UserDefaults.dataFormat.defaultValue
        
        return returnString
    }
    
    // Setting alreadyLaunchedStatus to provided value
    public static func setAlreadyLaunchedStatus(haveLaunched: Bool) {
        defaults.set(haveLaunched, forKey: Constants.UserDefaults.alreadyLaunched.key)
    }
    
    // Setting globalNotificationStatus to provided value
    public static func setUserGlobalNotificationStatus(isOn: Bool) {
        defaults.set(isOn, forKey: Constants.UserDefaults.globalNotificationStatus.key)
    }
    
    // Setting dataFormat to provided value
    public static func setDataFormat(dataFormat: String) {
        defaults.set(dataFormat, forKey: Constants.UserDefaults.dataFormat.key)
    }
    
    // Setting timeFormat to provided value
    public static func setTimeFormat(timeFormat: String) {
        defaults.set(timeFormat, forKey: Constants.UserDefaults.timeFormat.key)
    }
    
    // Setting fiatCurrency to provided value
    public static func setFiatCurrency(fiatCurrency: String) {
        defaults.set(fiatCurrency, forKey: Constants.UserDefaults.fiatCurrency.key)
    }
    
}
