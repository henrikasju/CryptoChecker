//
//  PreferenceSwitchBased.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class PreferenceSwitchBased: NSObject {
    let title: String
    let onStatus: Bool
    
    init(title: String, onStatus: Bool) {
        self.title = title
        self.onStatus = onStatus
    }
}
