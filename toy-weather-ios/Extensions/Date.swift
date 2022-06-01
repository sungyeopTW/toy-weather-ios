//
//  Date.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/30.
//

import Foundation

import Then

extension Date {
    
    /// 오늘의 "yyyyMMdd"
    func dateOfToday() -> String {
        let today = Date()
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyyMMdd"
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        return dateFormatter.string(from: today)
    }
    
    /// 어제의 "yyyyMMdd"
    func dateOfYesterday() -> String {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyyMMdd"
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        return dateFormatter.string(from: yesterday)
    }
    
    /// 현재 "HH"
    func currentHour() -> String {
        let today = Date()
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "HH"
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        return dateFormatter.string(from: today)
    }
    
    /// 한시간 전 "HH"
    func beforeOneHour() -> String {
        let today = Date()
        let oneHourEarlier = Calendar.current.date(byAdding: .hour, value: -1, to: today)!
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "HH"
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        return dateFormatter.string(from: oneHourEarlier)
    }
    
    /// 현재 "mm"
    func currentMinute() -> String {
        let today = Date()
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "mm"
            $0.locale = Locale(identifier: "ko_KR")
        }
        
        return dateFormatter.string(from: today)
    }
    
}
