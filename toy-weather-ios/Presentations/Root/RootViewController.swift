//
//  RootViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then

// MARK: - SendDataFromTableViewCell

protocol SendDataFromTableViewCell: AnyObject {
    
    func sendIsBookmarked(_ isBookmarked: Bool, _ cellData: City)
    
}


final class RootViewController: UIViewController {
    
    private var allCity: CityArray = []
    private var filteredCity: CityArray = []
    private var bookmarkedCity: CityArray = []
    
    private var isSearchActive = false
    private var isCelsius = true
    
    private let csvFileName: Url = "LocationSource"
    
    
    // MARK: - Enum
    
    enum Text {
        static let navigationBarTitle = "오늘의 날씨 정보 🧑🏻‍💼"
        static let searchControllerPlaceholder = "지역을 입력하세요 🗺"
    }
    
    
    // MARK: - UI

    private lazy var bookmarkTableView = UITableView().then {
        $0.dataSource = self /// self를 참조해야 하므로 lazy var
        $0.delegate = self
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 80
        $0.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
    }
    
    private lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: Image.thermometer)
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabThermometerButton)
    }
    
    private lazy var locationSearchTableView = UITableView().then {
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
        self.allCity = self.csvFileName.parseCSV()
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
        self.locationSearchTableView.reloadData()
        self.view = self.locationSearchTableView
    }
    
    // 서치 중
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCity = self.allCity.filter {
            $0.location.localizedCaseInsensitiveContains(searchText)
        }
        
        self.isSearchActive = true
        self.locationSearchTableView.reloadData()
    }
    
    // cancel 클릭 시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredCity = [] /// 초기화
        self.isSearchActive = false /// 초기화
        
        self.view = self.bookmarkTableView
    }
    
}


// MARK: - TableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    // section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case bookmarkTableView:
            return self.bookmarkedCity.count
        default:
            return self.isSearchActive ? self.filteredCity.count : self.allCity.count
        }
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == bookmarkTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell") as? BookmarkTableViewCell {
                cell.delegate = self
                cell.getData(self.isCelsius, self.bookmarkedCity[indexPath.row])
        
                return cell
            }
        }
        
        if tableView == locationSearchTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchTableViewCell") as? LocationSearchTableViewCell {
                cell.delegate = self
                cell.getData(
                    locationData: isSearchActive ? self.filteredCity[indexPath.row] : self.allCity[indexPath.row],
                    bookmarkedCity: bookmarkedCity
                )
                
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


// MARK: - SendDataFromWeatherDetailViewController

extension RootViewController: SendDataFromWeatherDetailViewController {
    
    // sendIsCelsius
    func sendIsCelsius(isCelsius: Bool) {
        self.isCelsius = isCelsius
        self.bookmarkTableView.reloadData()
    }
    
}


// MARK: - SendDataFromLocationSearchTableViewCell

extension RootViewController: SendDataFromTableViewCell {

    // sendIsBookmarked
    func sendIsBookmarked(_ isBookmarked: Bool, _ cellData: City) {
        if isBookmarked {
            self.bookmarkedCity.append(cellData)
        } else {
            self.bookmarkedCity = self.bookmarkedCity.filter({
                $0.id != cellData.id
            })
        }
    
        self.locationSearchTableView.reloadData()
        self.bookmarkTableView.reloadData()
    }

}
