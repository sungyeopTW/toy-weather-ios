//
//  CityManager.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/13.
//

import Foundation

/*
     - cityList라는 하나의 데이터소스에 만들고,
     - 그 데이터 소스를 원하는대로 가공하는 메소드를 만들고,
     - Reactor에서 해당 메소드들을 사용
 */

struct CityManager {
    
    // static var cityList = parseAllCityList()
     static var userDefaultData = cityListFromUserDefault()
     static var parsedData = parseAllCityList()
    static var cityList = parsedData
    // static var cityList = userDefaultData.isEmpty ? parseAllCityList() : userDefaultData
    

    
    // MARK: - Parse
    
    // 모든 CityList 가져옴
    private static func parseAllCityList() -> [City] {
        var result: [City] = []

        
        if let path = Bundle.main.path(forResource: "LocationSource", ofType: "csv") { /// 경로
            let url = URL(fileURLWithPath: path) /// URL
            
            do {
                let data = try Data(contentsOf: url) /// data 가져옴
                let encodedData = String(data: data, encoding: .utf8) /// encoding
                
                if let tmp = encodedData?
                    .components(separatedBy: "\n")
                    .map({ $0.components(separatedBy: ",") }) {
                        for index in 0...tmp.count - 2 { /// 마지막은 공백
                            result.append(
                                City(
                                    id: tmp[index][0], /// id
                                    location: tmp[index][4], /// 전체 주소
                                    x: tmp[index][5], /// x좌표
                                    y: tmp[index][6] /// y좌표
                                        .trimmingCharacters(in: CharacterSet.newlines), /// 개행문자 제거
                                    weather: WeatherModel(), /// 날씨
                                    isBookmarked: false /// 즐겨찾기 여부 TODO: 가능 ??
                                )
                            )
                        }
                    }
                
                return result
            } catch {
                print("Error reading CSV file")
            }
        }
        
        return []
    }
    
    
    // MARK: - UserDefault
    
    // cityList 저장
    private static func saveToUserDefault(_ cityList: [City]) {
        // let encode = JSONEncoder(cityList)
        // let data =
        
        UserDefaults.standard.set(cityList, forKey: "cityList")
    }
    
    // cityList 가져오기
    private static func cityListFromUserDefault() -> [City] {
        guard let cityList = UserDefaults.standard.array(forKey: "cityList") as? [City] else { return [] }
        return cityList
    }
    
    
    // MARK: - Methods
    
    // 모든 cityList
    private static func getAllCityList() -> [City] { return self.cityList }
    
    // 검색결과 cityList
    static func getSearchedCityList(from text: String) -> [City] {
        if text.isEmpty { return cityList }
        else { return self.cityList.filter { $0.location.contains(text) } }
    }
    
    // 즐겨찾기 cityList
    static func getBookmarkedCityList() -> [City] { return self.cityList.filter { $0.isBookmarked } }
    
    // 즐겨찾기 기능
    static func bookmark(id: String) {
        guard let index = self.cityList.firstIndex(where: { $0.id == id }) else { return }
        
        self.cityList[index].isBookmarked.toggle()
        // self.saveToUserDefault(self.cityList) /// userDefault에 저장
        // print(id, index, self.cityList[index].isBookmarked)
    }
}


// 날씨데이터 추가
// static func fetchWeather(id: String) {
//     guard let index = self.cityList.firstIndex(where: { $0.id == id }) else { return }
//     self.cityList[index].weather
// }
