//
//  RootViewReactor.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/13.
//

import ReactorKit

final class RootViewReactor: Reactor {
    
    // MARK: - Enum & State
    
    enum Action {
        case landing
        case toggleSearch
        case search(String)
        case bookmark(String, String?)
    }
    
    enum Mutation {
        case toggleIsSearchActive
        case filterSearchedCityList([City])
        case filterBookmarkedCityList([City])
    }
    
    struct State {
        var isSearchActive: Bool
        var searchedCityList: [City]
        var bookmarkedCityList: [City]
    }
    
    var initialState: State = .init(
        isSearchActive: false,
        searchedCityList: [],
        bookmarkedCityList: []
    )
    
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .landing:
            return .just(.filterBookmarkedCityList(CityManager.getBookmarkedCityList()))
        case .toggleSearch:
            return .of(
                .toggleIsSearchActive,
                .filterSearchedCityList(CityManager.getSearchedCityList(from: ""))
            )
        case .search(let text):
            return .just(.filterSearchedCityList(CityManager.getSearchedCityList(from: text)))
        case .bookmark(let id, let text):
            CityManager.bookmark(id: id)
            
            if let text = text {
                return .of(
                    .filterBookmarkedCityList(CityManager.getBookmarkedCityList()),
                    .filterSearchedCityList(CityManager.getSearchedCityList(from: text))
                )
            } else {
                return .just(.filterBookmarkedCityList(CityManager.getBookmarkedCityList()))
            }
        }
    }
    
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case .filterSearchedCityList(let searchedCityList):
            newState.searchedCityList = searchedCityList
        case .toggleIsSearchActive:
            newState.isSearchActive.toggle()
        case .filterBookmarkedCityList(let bookmarkedCityList):
            newState.bookmarkedCityList = bookmarkedCityList
        }
        
        return newState
    }
    
}
