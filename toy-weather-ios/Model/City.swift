//
//  City.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/24.
//


// MARK: - DataModel

// struct City {
//     var id: String
//     var location: String
//     var x: String
//     var y: String
//     var weather: WeatherModel
//     var isBookmarked: Bool
// }
//
// extension City: Hashable, Equatable {
//     static func == (lhs: City, rhs: City) -> Bool {
//         return lhs.id == rhs.id
//     }
//
//     func hash(into hasher: inout Hasher) {
//         hasher.combine(id)
//     }
// }


struct City {
    var id: String
    var location: String
    var x: String
    var y: String
    var weather: WeatherModel
    var isBookmarked: Bool
}

extension City: Hashable, Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
