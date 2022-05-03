//
//  BookmarkTableView.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import Then

class BookmarkTableView: UITableView {
    
    var tableViewCellCount = 10
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - BookmarkTableViewDataSource

extension BookmarkTableView: UITableViewDataSource {
    
    // Section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellCount
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "즐겨찾기 된 지역 셀"
        
        return cell
    }
    
}
