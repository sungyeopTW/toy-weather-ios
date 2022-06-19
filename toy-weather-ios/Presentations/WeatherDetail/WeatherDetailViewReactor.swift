//
//  WeatherDetailViewReactor.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/16.
//

import ReactorKit

final class WeatherDetailViewReactor: Reactor {
    
    // MARK: - Enum & State
    
    enum Action {
        case landing
        case refresh
        case bookmark(_ bookmarkId: String)
    }
    
    enum Mutation {
        case updateCityState(_ city: City)
        case refreshScrollView
        case toggleBookmark
    }
    
    struct State {
        var city: City
    }
    
    var initialState: State = .init(
        city: City(
            id: "", location: "", x: "0", y: "0",
            weather: WeatherModel(
                sky: .initial,
                currentTemperature: Temperature(celsius: 0),
                highestTemperature: Temperature(celsius: 0),
                lowestTemperature: Temperature(celsius: 0),
                windDirection: .initial, windSpeed: "m/s", rainProbability: "%"
            ),
            isBookmarked: false
        )
    )
    
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .landing:
            return .concat([
                CityManager.updateVilageDataOnCityList(self.currentState.city).map { city in
                    let newData = CityManager.allCityList.filter { $0.id == city.id }[0]
                    return .updateCityState(newData)
                },
                CityManager.updateUltraSrtDataOnCityList([self.currentState.city]).map { city in
                    let newData = CityManager.allCityList.filter { $0.id == city.id }[0]
                    return .updateCityState(newData)
                }
            ])
        case .refresh:
            return .just(.refreshScrollView)
        case .bookmark(let bookmarkId):
            CityManager.bookmark(id: bookmarkId)
            
            return .concat([
                .just(.toggleBookmark),
                .just(.refreshScrollView)
            ])
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation.observe(on: MainScheduler.instance)
    }
    
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateCityState(let city):
            newState.city = city
        case .refreshScrollView:
            newState = state
        case .toggleBookmark:
            newState.city.isBookmarked.toggle()
        }
        
        return newState
    }
    
}
