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
                
        // if App launched for the first time, configure default preferences
        if !UserDefaultsManager.getAlreadyLaunchedStatus() {
            print("Never launched before")
            
            UserDefaultsManager.setAlreadyLaunchedStatus(haveLaunched: true)
            // Setting global notificatino status
            UserDefaultsManager.setUserGlobalNotificationStatus(isOn: Constants.UserDefaults.globalNotificationStatus.defaultValue)
            // Setting data format
            UserDefaultsManager.setDataFormat(dataFormat: Constants.UserDefaults.dataFormat.defaultValue)
            // Setting time format
            UserDefaultsManager.setTimeFormat(timeFormat: Constants.UserDefaults.timeFormat.defaultValue)
            // Setting Fiat currency
            UserDefaultsManager.setFiatCurrency(fiatCurrency: Constants.UserDefaults.fiatCurrency.defaultValue)
        }else{
            print("Had launched before")
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

