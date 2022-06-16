//
//  WeatherDetailViewReactor.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/16.
//

import ReactorKit

final class WeatherDetailViewReactor: Reactor {
    
    // MARK: - Enum & State
    
    enum Action {}
    
    enum Mutation {}
    
    struct State {}
    
    var initialState: State = .init()
    
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return mutation.observe(on: MainScheduler.instance)
    }
    
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
    
}
