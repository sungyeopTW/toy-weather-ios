//
//  Temperature.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/17.
//

typealias Celsius = Double

extension Celsius {
    
    // 기호 포매팅
    func convertWithFormat(_ format: Symbol) -> String {

        // format을 기준으로 temperatureValue구함
        let temperatureValue: Double = {
            switch format {
            case .celsius:
                return self
            case .fahrenheit:
                return self * 1.8 + 32.0
            }
        }()
        
        return .init(format: "%.1f\(format.rawValue)", temperatureValue) /// enum 의 값에 접근할 때에는 rawValue
    }
    
}
