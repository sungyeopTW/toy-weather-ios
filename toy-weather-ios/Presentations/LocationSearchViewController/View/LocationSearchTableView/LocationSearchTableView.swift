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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func setupLocationSearchTableView() {
        self.dataSource = self
        self.isHidden = true
        
        self.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        self.register(
            LocationSearchViewCell.self,
            forCellReuseIdentifier: "locationSearchViewCell"
        )
        self.register(
            LocationSearchViewEmptyCell.self,
            forCellReuseIdentifier: "locationSearchViewEmptyCell"
        )
        

    }
    
}


// MARK: - LocationSearchTableViewDataSource

extension LocationSearchTableView: UITableViewDataSource {
    
    // Section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellCount == 0 ? 1 : self.tableViewCellCount
    }
    
    // cell
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: self.tableViewCellCount == 0
                ? "locationSearchViewEmptyCell"
                : "locationSearchViewCell",
            for: indexPath
        )
        
        if tableViewCellCount == 0 { cell.selectionStyle = .none }
        
        return cell
    }
    
}
