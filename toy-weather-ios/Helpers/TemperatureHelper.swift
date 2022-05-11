//
//  TemperatureHelper.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//


// MARK: - TemperatureHelperProtocol

protocol TemperatureHelperProtocol: AnyObject {
    
    func transformTemperatureToFahrenheit(_ celsiusValue: Int) -> Int
    
}


// MARK: - TemperatureHelper

final class TemperatureHelper: TemperatureHelperProtocol {
    
    // 화씨로 온도 변형
    func transformTemperatureToFahrenheit(_ celsiusValue: Int) -> Int {
        let fahrenheitValue = (Double(celsiusValue) * 1.8) + 32
        
        return Int(fahrenheitValue)
    }
    
}

