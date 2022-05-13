//
//  TemperatureHelper.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//


// MARK: - TemperatureHelperProtocol

protocol TemperatureHelperProtocol: AnyObject {
    
    func toFahrenheit(from celsiusValue: String) -> Int
    
}


// MARK: - TemperatureHelper

final class TemperatureHelper: TemperatureHelperProtocol {
    
    // 화씨로 온도 변형
    func toFahrenheit(from celsiusValue: String) -> Int {
        if let celsiusValue = Int(celsiusValue) {
            let fahrenheitValue = (Double(celsiusValue) * 1.8) + 32
            
            return Int(fahrenheitValue)
        }
        
        return 0
    }
    
}

