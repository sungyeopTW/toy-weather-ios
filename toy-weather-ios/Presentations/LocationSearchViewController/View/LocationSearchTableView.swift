//
//  LocationSearchTableView.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

class LocationSearchTableView: UITableView {
    
    var tableViewCellCount = 0
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - LocationSearchTableViewDataSource

extension LocationSearchTableView: UITableViewDataSource {
    // Section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellCount
    }
    
    // cell
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell().then({
            $0.textLabel?.text = "검색할 지역 뜨는 셀!!!"
        })
        
        return cell
    }
}
