//
//  WeatherManager.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/01.
//

import Foundation


struct WeatherManager {
    
    static let baseURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0"
    static let serviceKey = "DPZHSAzQK%2F%2BnFFK8YL11qOMes37yZqXcryyCEnyheS"
                            + "zmNkFiVSeKLCLDsXu4tOYBHhsWdaDHZfisjbq7rA5dFQ%3D%3D"
    static let pageNo = "1"
    static let numOfRows = "200"
    static let dataType = "JSON"
    
    
    // MARK: - Methods
    
    // baseDate 산출
    private static func baseDateForEndPoint(_ fcstType: FcstType) -> String {
        let currentHour = Int(Date().currentHour()) ?? 0
        let currentMinute = Int(Date().currentMinute()) ?? 0
        
        if fcstType == .vilageFcst { /// 23:10 이전이면 전날
            if currentHour < 23 {
                return Date().dateOfYesterday()
            }
        
            else if currentHour == 23 && currentMinute < 10 {
                return Date().dateOfYesterday()
            }
        }
        
        return Date().dateOfToday()
    }
    
    // baseTime 산출
    private static func baseTimeForEndPoint(_ fcstType: FcstType) -> String {
        switch fcstType {
        case .ultraSrtFcst: /// 기준 30분, 매 시간 45분 업데이트
            let currentMinute = Int(Date().currentMinute()) ?? 0
            
            if currentMinute < 45 {
                return "\(Date().beforeOneHour())30"
            }
            
            return "\(Date().currentHour())30"
        case .vilageFcst: /// 항상 2300
            return "2300"
        }
    }
    
    // EndPoint
    static func endPoint(_ fcstType: FcstType, _ locationData: City) -> URL {
        let baseDate = self.baseDateForEndPoint(fcstType)
        let baseTime = self.baseTimeForEndPoint(fcstType)
        
        guard let url = URL(
            string: "\(baseURL)/\(fcstType.rawValue)"
                + "?serviceKey=\(serviceKey)&pageNo=\(pageNo)"
                + "&numOfRows=\(numOfRows)&dataType=\(dataType)"
                + "&base_date=\(baseDate)"
                + "&base_time=\(baseTime)"
                + "&nx=\(locationData.x)&ny=\(locationData.y)"
        ) else {
            fatalError("endPoint를 가져올 수 없습니다.")
        }
        
        return url
    }
    
    // skyStatus
    static func skyStatus(_ pty: String, _ sky: String) -> Sky {
        switch pty {
        case "0":
            if sky == "1" {
                return .sunny
            } else {
                return .clouds
            }
        case "1", "2", "5":
            return .rain
        case "3", "6", "7":
            return .snow
        default:
            fatalError("[하늘상태 계산 중 에러 발생] : 예상외의 pty 또는 sky가 들어옴")
        }
    }
    
    // windStatus
    static func windStatus(_ vec: String) -> Compass {
        let vecValue = Int(vec) ?? 0
        
        if vecValue >= 23 && vecValue < 68 {
            return .northEast
        }
        else if vecValue >= 68 && vecValue < 113 {
            return .east
        }
        else if vecValue >= 113 && vecValue < 158 {
            return .southEast
        }
        else if vecValue >= 158 && vecValue < 203 {
            return .south
        }
        else if vecValue >= 203 && vecValue < 248 {
            return .southWest
        }
        else if vecValue >= 248 && vecValue < 293 {
            return .west
        }
        else if vecValue >= 293 && vecValue < 338 {
            return .northWest
        }
        else {
            return .north
        }
    }
}
