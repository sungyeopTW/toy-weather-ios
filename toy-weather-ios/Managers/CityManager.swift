//
//  CityManager.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/13.
//

import Foundation

import ReactorKit

/*
     - cityList라는 하나의 데이터소스에 만들고,
     - 그 데이터 소스를 원하는대로 가공하는 메소드를 만들고,
     - Reactor에서 해당 메소드들을 사용
 */

struct CityManager {
    
    static var allCityList = UserDefaultsManager.loadCityList().isEmpty
                    ? parseAllCityList()
                    : UserDefaultsManager.loadCityList()

    
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
                                    isBookmarked: false /// 즐겨찾기 여부
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
    
    
    // MARK: - Filter CityList
    
    // 즐겨찾기 cityList 필터
    static func getBookmarkedCityList() -> [City] { return self.allCityList.filter { $0.isBookmarked }}
    
    // 검색결과 cityList 필터
    static func getSearchedCityList(from text: String = "") -> [City] {
        if text.isEmpty { return allCityList }
        else { return self.allCityList.filter { $0.location.contains(text) } }
    }
    
    // 검색결과 + 즐겨찾기 cityList 필터
    static func filterCityLists(_ text: String = "") -> ([City], [City]) {
        let bookmarkedCityList = self.getBookmarkedCityList()
        let searchedCityList: [City] = {
            if text.isEmpty { return allCityList }
            else { return self.getSearchedCityList(from: text) }
        }()
        
        return (bookmarkedCityList, searchedCityList)
    }
    
    
    // MARK: - Methods
    
    // 즐겨찾기 기능
    static func bookmark(id: String) {
        guard let index = self.allCityList.firstIndex(where: { $0.id == id }) else { return }
        
        self.allCityList[index].isBookmarked.toggle()
        UserDefaultsManager.saveCityList(self.allCityList)  /// userDefault에 저장
    }
    
    // allCity에서 index 찾기
    private static func findIndex(_ city: City) -> Array<City>.Index {
        return self.allCityList.firstIndex(of: city)!
    }
    
    
    // MARK: - Fetch
    
    // 초단기예보 to CityList
    static func updateUltraSrtDataOnCityList(_ cityList: [City]) -> Observable<City> {
        return .create { observer -> Disposable in
            var completedCount = 0
            let disposables = cityList.map { city in
                return WeatherManager.fetchUltraSrtData(of: city)
                    .subscribe(
                        onNext: { weather in
                            let index = self.findIndex(city)
                            self.allCityList[index].weather.sky = weather.sky /// bilageData가 덮어쓰이지 않도록
                            self.allCityList[index].weather.currentTemperature = weather.currentTemperature
                            self.allCityList[index].weather.windDirection = weather.windDirection
                            self.allCityList[index].weather.windSpeed = weather.windSpeed
                            observer.onNext(self.allCityList[index])
                        },
                        onError: observer.onError,
                        onCompleted: {
                            completedCount < cityList.count ? completedCount += 1 : observer.onCompleted()
                        })
            }
            
            return Disposables.create(disposables)
        }
    }
    
    // 단기예보 to CityList
    static func updateVilageDataOnCityList(_ city: City) -> Observable<City> {
        return .create { observer -> Disposable in
            let disposable = WeatherManager.fetchVilageData(of: city)
                    .subscribe(
                        onNext: { weather in
                            let index = self.findIndex(city)
                            self.allCityList[index].weather.highestTemperature = weather.highestTemperature
                            self.allCityList[index].weather.lowestTemperature = weather.lowestTemperature
                            self.allCityList[index].weather.rainProbability = weather.rainProbability
                        },
                        onError: observer.onError,
                        onCompleted: observer.onCompleted
                    )
            
            return Disposables.create([disposable])
        }
    }
    
}
