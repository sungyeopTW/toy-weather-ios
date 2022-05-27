//
//  ButtonInteractionDelegate.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/27.
//

protocol ButtonInteractionDelegate: AnyObject {
    func didTabBookmarkButton(_ isBookmarked: Bool)
    func didTabBookmarkButtonOnCell(_ isBookmarked: Bool, on cellData: City)
    
    func didTabTemperatureButton(_ isCelsius: Bool)
}

// for optional
extension ButtonInteractionDelegate {
    func didTabBookmarkButton(_ isBookmarked: Bool) {}
    func didTabBookmarkButtonOnCell(_ isBookmarked: Bool, on cellData: City) {}
    
    func didTabTemperatureButton(_ isCelsius: Bool) {}
}
