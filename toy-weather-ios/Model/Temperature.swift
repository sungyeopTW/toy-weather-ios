//
//  Temperature.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/17.
//

// 섭씨, 화씨
enum TemperatureSymbol: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

struct Temperature {
    var celsius: Double
    
    func convertWithFormat(_ format: TemperatureSymbol) -> String {
        let temperatureValue: Double = {
            switch format {
            case .celsius:
                return celsius
            case .fahrenheit:
                return celsius * 1.8 + 32.0
            }
        }()
        
        return .init(format: "%.1f\(format.rawValue)", temperatureValue)
    }
}
