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
                        for i in 1...tempArr.count-1 {
                            dataArr.append(tempArr[i]) /// 0번째 index는 불필요 데이터
                        }
                    }
            } catch {
                print("Error reading CSV file")
            }
    
        }
    }
    
}
