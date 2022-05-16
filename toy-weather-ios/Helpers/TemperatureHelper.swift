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
    
    // 화씨로 온도 변형 // 타입으로
    func toFahrenheit(from celsiusValue: String) -> Int { // static 또는 class
        if let celsiusValue = Int(celsiusValue) {
            let fahrenheitValue = (Double(celsiusValue) * 1.8) + 32
            
            return Int(fahrenheitValue)
        }
        
        return 0
    }
    
}


// protocol 온도단위 {
//     var 온도: Double { get }
// }
//
// struct 섭씨: 온도단위 {
//
//     var 온도: Double
// }
//
// extension 섭씨 {
//     var 화씨로: 화씨 {
//         .init(온도: self.온도 * 1.8 + 32.0)
//     }
// }
//
// struct 화씨: 온도단위 {
//
//     var 온도: Double
// }
//
// extension 화씨 {
//     var 섭씨로: 섭씨 {
//         .init(온도:(self.온도 - 32.0) / 1.8)
//     }
// }

