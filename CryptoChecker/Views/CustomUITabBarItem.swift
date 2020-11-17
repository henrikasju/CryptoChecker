//
//  CustomUITabBarItem.swift
//  CryptoChecker
//
//  Created by Henrikas J on 17/11/2020.
//

import UIKit

class CustomUITabBarItem: UITabBarItem {
    
    override init() {
        super.init()
        
        image = UIImage(systemName: "eyeglasses")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
