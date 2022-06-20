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
        case refresh(_ bookmarkId: String?, _ searchText: String?)
        case toggleSearch(_ isSearch: Bool, _ searchText: String?)
        case search(_ searchText: String)
    }
    
    enum Mutation {
        case toggleIsSearchActive(_ isSearch: Bool)
        case filter(_ filteredCityLists: ([City], [City]))
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
        case .refresh(let bookmarkId, let searchText):
            if let bookmarkId = bookmarkId { CityManager.bookmark(id: bookmarkId) }
            
            return .concat([
                .just(.filter(CityManager.filterCityLists(searchText ?? ""))),
                CityManager.updateUltraSrtDataOnCityList(CityManager.getBookmarkedCityList()).map { _ in
                    .filter(CityManager.filterCityLists(searchText ?? ""))
                }
            ])
        case .toggleSearch(let isSearch, let searchText):
            return .concat([
                .just(.toggleIsSearchActive(isSearch)),
                .just(.filter(CityManager.filterCityLists(searchText ?? "")))
            ])
        case .search(let searchText):
            return .just(.filter(CityManager.filterCityLists(searchText)))
        }
    }
    
    // reduce로 넘어갈 때 메인쓰레드로~~~
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation.observe(on: MainScheduler.instance)
    }
    
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .toggleIsSearchActive(let isSearch):
            newState.isSearchActive = isSearch
        case .filter(let filteredCityLists):
            newState.bookmarkedCityList = filteredCityLists.0
            newState.searchedCityList = filteredCityLists.1
        }
        
        return newState
    }
    
}
