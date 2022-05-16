//
//  LocationSearchViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/15.
//

import UIKit

import Then


final class LocationSearchViewController: UIViewController {
    
    var searchCount = 10
    var navigation: UINavigationController?
    
    let weatherDetailViewController = WeatherDetailViewController()
    
    
    // MARK: - UI
    
    lazy var locationSearchTableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 50
        $0.register(
            LocationSearchTableViewCell.self,
            forCellReuseIdentifier: "LocationSearchTableViewCell"
        )
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.locationSearchTableView
    }
    
}


// MARK: - LocationSearchTableViewDataSource

extension LocationSearchViewController: UITableViewDataSource {
    
    // section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCount
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchTableViewCell") {
            return cell
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - LocationSearchTableViewDelegate

extension LocationSearchViewController: UITableViewDelegate {
    
    // tab event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let navigation = self.navigation {
            navigation.pushViewController(weatherDetailViewController, animated: true)
        }
    }
    
}
