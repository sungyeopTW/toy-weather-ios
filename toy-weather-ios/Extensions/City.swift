//
//  City.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/24.
//


typealias City = [String]
typealias CityArray = [City]
typealias BookmarkedCity = [String]

extension City {
    
    var id: String { return self[0] } /// id
    var location: String { return self[1] } /// 주소
    var x: String { return self[2] } /// x좌표
    var y: String { return self[3] } /// y좌표
    
}
