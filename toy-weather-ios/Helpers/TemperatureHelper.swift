//
//  TemperatureHelper.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//


// MARK: - TemperatureHelper

struct TemperatureHelper {
    
    static func toFahrenheit(_ celsiusValue: Double) -> Double {
        return celsiusValue * 1.8 + 32.0
    }
    
    static func toCelsius(_ fahrenheitValue: Double) -> Double {
        return (fahrenheitValue - 32.0) / 1.8
    }
    
}
