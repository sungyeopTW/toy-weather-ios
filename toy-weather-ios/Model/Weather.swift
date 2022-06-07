//
//  Weather.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/30.
//


// MARK: - Codable

class WeatherData: Codable {
    var response: WeatherResponse
}

struct WeatherResponse: Codable {
    let body: WeatherBody
}

struct WeatherBody: Codable {
    let items: WeatherItems
}

struct WeatherItems: Codable {
    let item: [WeatherItem]
}

struct WeatherItem: Codable {
    let category: String // 자료구분코드
    let fcstDate: String // 예측일자
    let fcstTime: String // 예측시간
    let fcstValue: String // 예보 값
    let nx: Int
    let ny: Int
}


// MARK: - Enum

// 예보종류
enum FcstType: String {
    case ultraSrtFcst = "getUltraSrtFcst"
    case vilageFcst = "getVilageFcst"
}

// 날씨 카테고리
enum WeatherCategory: String {
    case sky = "SKY"
    case currentTemperature = "T1H"
    case highestTemperature = "TMX"
    case lowestTempeerature = "TMN"
    case windDirection = "VEC"
    case windSpeed = "WSD"
    case rainfallType = "PTY"
    case rainProbability = "POP"
}

// 하늘상태
enum Sky: String {
    case initial = ""
    case sunny = "맑음"
    case clouds = "흐림"
    case rain = "비"
    case snow = "눈"
}

// 방위
enum Compass: String {
    case initial = ""
    case north = "북"
    case northEast = "북동"
    case east = "동"
    case southEast = "남동"
    case south = "남"
    case southWest = "남서"
    case west = "서"
    case northWest = "북서"
}
