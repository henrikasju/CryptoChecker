//
//  Extentions.swift
//  CryptoChecker
//
//  Created by Henrikas J on 16/11/2020.
//

import UIKit

extension UIColor {
    public convenience init?(rgbRed: Int, rgbGreen: Int, rgbBlue: Int, alpha: CGFloat) {
        
        if rgbRed <= 255 && rgbGreen <= 255 && rgbBlue <= 255 && alpha <= 1.0{
            self.init(red: CGFloat(rgbRed)/255.0, green: CGFloat(rgbRed)/255.0, blue: CGFloat(rgbRed)/255.0, alpha: alpha)
            return
        }
        
        return nil
        
    }
}
