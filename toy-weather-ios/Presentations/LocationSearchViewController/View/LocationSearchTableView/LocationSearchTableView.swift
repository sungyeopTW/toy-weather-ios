//
//  LocationSearchTableView.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import Then

final class LocationSearchTableView: UITableView {
    
    var tableViewCellCount = 10
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setupLocationSearchTableView()
        self.setupTableViewSearator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func setupLocationSearchTableView() {
        self.dataSource = self
        self.register(LocationSearchViewCell.self, forCellReuseIdentifier: "locationSearchViewCell")
        self.isHidden = true
    }
    
    private func setupTableViewSearator() {
        switch self.tableViewCellCount {
        case 0:
            self.separatorStyle = .none
        default:
            self.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
            self.separatorColor = .black
        }
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "locationSearchViewCell",
            for: indexPath
        )
        
        // TODO : 검색결과가 없을 경우 LocationSearchTableViewEmptyCell 넣어야 함
        
        return cell
    }
    
}
