//
//  CSV.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/23.
//

import Foundation

struct CSV {
    var value: String
    
    func parseToCityArray() -> [City] {
        var result: [City] = []
        
        if let path = Bundle.main.path(forResource: value, ofType: "csv") { /// 경로
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
                                        .trimmingCharacters(in: CharacterSet.newlines) /// 개행문자 제거
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
}
