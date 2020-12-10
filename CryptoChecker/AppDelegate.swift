//
//  AppDelegate.swift
//  CryptoChecker
//
//  Created by Henrikas J on 14/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let defaults = UserDefaults.standard
        
        // if App launched for the first time, configure default preferences
        if !defaults.bool(forKey: Constants.UserDefaults.alreadyLaunched.key) {
            print("Never launched before")
            
            defaults.set(true, forKey: Constants.UserDefaults.alreadyLaunched.key)
            // Setting global notificatino status
            defaults.set(Constants.UserDefaults.globalNotificationStatus.defaultValue, forKey: Constants.UserDefaults.globalNotificationStatus.key)
            // Setting data format
            defaults.set(Constants.UserDefaults.dataFormat.defaultValue, forKey: Constants.UserDefaults.dataFormat.key)
            // Setting time format
            defaults.set(Constants.UserDefaults.timeFormat.defaultValue, forKey: Constants.UserDefaults.timeFormat.key)
            // Setting Fiat currency
            defaults.set( Constants.UserDefaults.fiatCurrency.defaultValue, forKey: Constants.UserDefaults.fiatCurrency.key)
        }else{
            print("Had launched before")
            var settings: [String:Any] = [:]
            
            settings[Constants.UserDefaults.alreadyLaunched.key] = defaults.bool(forKey: Constants.UserDefaults.alreadyLaunched.key)
            
            settings[Constants.UserDefaults.globalNotificationStatus.key] = defaults.bool(forKey: Constants.UserDefaults.globalNotificationStatus.key)
            
            settings[Constants.UserDefaults.dataFormat.key] = defaults.string(forKey: Constants.UserDefaults.dataFormat.key)
            
            settings[Constants.UserDefaults.timeFormat.key] = defaults.string(forKey: Constants.UserDefaults.timeFormat.key)
            
            settings[Constants.UserDefaults.fiatCurrency.key] = defaults.string(forKey: Constants.UserDefaults.fiatCurrency.key)
            
            print(settings)
            
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

