//
//  UserDefaultManager.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/14.
//

import Foundation

struct UserDefaultManager {
    
    // cityList 저장
    static func saveCityList(_ cityList: [City]) {
        guard let encodedData = try? JSONEncoder().encode(cityList) else { return }
        UserDefaults.standard.set(encodedData, forKey: "cityList")
    }
    
    // cityList 가져오기
    static func loadCityList() -> [City] {
        guard let savedData = UserDefaults.standard.object(forKey: "cityList") as? Data,
              let decodedData = try? JSONDecoder().decode([City].self, from: savedData)
        else { return [] }
        
        return decodedData
    }
    
    // isCelsius 저장
    static func saveIsCelsius(_ isCelsius: Bool) {
        guard let encodedData = try? JSONEncoder().encode(isCelsius) else { return }
        UserDefaults.standard.set(encodedData, forKey: "isCelsius")
    }
    
    // isCelsius 가져오기
    static func loadIsCelsius() -> Bool {
        guard let savedData = UserDefaults.standard.object(forKey: "isCelsius") as? Data,
              let decodedData = try? JSONDecoder().decode(Bool.self, from: savedData)
        else { return true }
        
        return decodedData
    }
    
}
