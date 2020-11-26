//
//  Preference.swift
//  CryptoChecker
//
//  Created by Henrikas J on 18/11/2020.
//

import UIKit

class PreferenceTextBased: NSObject{
    class Option: NSObject {
        let title: String
        var selected: Bool
        
        init(title: String, selected: Bool) {
            self.title = title
            self.selected = selected
        }
    }
    
    let title: String
    var options: [Option]
    var detail: String
    var selectedOption: Option?
    
    init(title: String, options: [Option]) {
        self.title = title
        self.options = options
        
        self.detail = ""
        for option in options {
            if option.selected {
                self.detail = option.title
                self.selectedOption = option
                break
            }
        }
    }
    
}
