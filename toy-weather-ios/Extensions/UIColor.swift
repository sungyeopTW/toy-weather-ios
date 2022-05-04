//
//  UIColor.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//

import UIKit

extension UIColor {
    
    // hex code 지원
    public convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
    
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
