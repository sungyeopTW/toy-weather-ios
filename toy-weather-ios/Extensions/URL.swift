//
//  URL.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/23.
//

import Foundation

typealias Url = String

extension Url {
    
    func parseCSV(to dataArr: inout [[String]]) {
        if let path = Bundle.main.path(forResource: self, ofType: "csv") { /// 파일경로
            let url = URL(fileURLWithPath: path) /// URL
    
            do {
                let data = try Data(contentsOf: url) /// data 가져옴
                let encodedData = String(data: data, encoding: .utf8) /// encoding
                
                if let tempArr = encodedData?
                    .components(separatedBy: "\n")
                    .map({ $0.components(separatedBy: ",") }) {
                        for index in 0...tempArr.count - 2 { /// 마지막은 공백
                            dataArr.append([ /// 전체주소, x, y 만 append
                                tempArr[index][3], tempArr[index][4], tempArr[index][5]
                            ])
                        }
                    }
            } catch {
                print("Error reading CSV file")
            }
    
        }
    }
    
}
