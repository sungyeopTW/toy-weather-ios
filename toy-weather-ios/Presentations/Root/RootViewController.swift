//
//  RootViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then


final class RootViewController: UIViewController {
    
    var cityAndCountry: [[String]] = []
    
    var searchCount = 10
    var bookmarkCount = 3
    var isCelsius = true
    
    let csvFileName: Url = "LocationSource"
    
    
    // MARK: - Enum
    
    enum Text {
        static let navigationBarTitle = "오늘의 날씨 정보 🧑🏻‍💼"
        static let searchControllerPlaceholder = "지역을 입력하세요 🗺"
    }
    
    
    // MARK: - UI

    lazy var bookmarkTableView = UITableView().then {
        $0.dataSource = self /// self를 참조해야 하므로 lazy var
        $0.delegate = self
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 80
        $0.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
    }
    
    lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: Image.thermometer)
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabThermometerButton)
    }
    
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
        self.setupNavigationController()
    }

    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.bookmarkTableView
    }
    
    private func setupNavigationController() {
        // NavigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // NavigationItem
        self.navigationItem.title = Text.navigationBarTitle
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = UISearchController().then {
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = Text.searchControllerPlaceholder
            $0.hidesNavigationBarDuringPresentation = true
        }
        self.navigationItem.rightBarButtonItem = self.thermometerButton
    }
    
    // tabThermometerButton
    @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()
        self.bookmarkTableView.reloadData()
    }
    
}


// MARK: - SearchBarDelegate

extension RootViewController: UISearchBarDelegate {
    
    // 서치 시작
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.csvFileName.parseCSV(to: &cityAndCountry)
        
        self.view = self.locationSearchTableView
        print(cityAndCountry)
    }
    
    // 서치 중
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    // cancel 클릭 시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view = self.bookmarkTableView
    }
    
}


// MARK: - TableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    // section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == bookmarkTableView ? self.bookmarkCount : self.cityAndCountry.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bookmarkTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell") as? BookmarkTableViewCell {
                cell.initialize(self.isCelsius)
        
                return cell
            }
        }
        
        if tableView == locationSearchTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchTableViewCell") as? LocationSearchTableViewCell {
                cell.initialize(cityAndCountry[indexPath.row])
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - TableViewDelegate

extension RootViewController: UITableViewDelegate {
    
    // tab event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherDetailViewController = WeatherDetailViewController()
        weatherDetailViewController.delegate = self // delegate
        weatherDetailViewController.isCelsius = self.isCelsius
        
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
}


// MARK: - SendIsCelsiusDelegate

extension RootViewController: SendIsCelsiusDelegate {
    
    // sendIsCelsius
    func sendIsCelsius(isCelsius: Bool) {
        self.isCelsius = isCelsius
        self.bookmarkTableView.reloadData()
    }
    
}
