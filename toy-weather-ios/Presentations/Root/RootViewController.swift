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
    
    private var allCity = CSV(value: "LocationSource").parseToCityArray()
    private var filteredCity: [City] = []
    private var bookmarkedCity: [City] = []
    private var temperatureWithBookmarkedCityId: [String: Temperature] = [:]
    
    private var isSearchActive = false
    private var isCelsius = true
    
    
    // MARK: - Enum
    
    enum Text {
        static let navigationBarTitle = "오늘의 날씨 정보 🧑🏻‍💼"
        static let searchControllerPlaceholder = "지역을 입력하세요 🗺"
    }
    
    
    // MARK: - UI

    private lazy var bookmarkTableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 80
        $0.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
    }
    
    private lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "thermometer")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.fetchUltraSrtData(bookmarkedCity)
    }

    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.bookmarkTableView
    }
    
    private func setupNavigationController() {
        // NavigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // NavigationItem
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = Text.navigationBarTitle
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = UISearchController().then {
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = Text.searchControllerPlaceholder
            $0.hidesNavigationBarDuringPresentation = true
        }
        self.navigationItem.rightBarButtonItem = self.thermometerButton
    }
    
    // 초단기예보 -- 현재기온
    private func fetchUltraSrtData(_ bookmarkedCity: [City]) {
        let session = URLSession(configuration: .default)
    
        if !bookmarkedCity.isEmpty { /// 즐찾이 있으면
            for locationData in bookmarkedCity { /// 각각
                let endPoint = WeatherManager.endPoint(.ultraSrtFcst, locationData)
    
                session.dataTask(with: endPoint) { data, response, error in
                    if let data = data {
                        do {
                            let apiData = try JSONDecoder().decode(WeatherData.self, from: data)
                            let itemArray = apiData.response.body.items.item
    
                            let neartime = itemArray[0].fcstTime
                            let resultData = itemArray.filter {
                                if $0.fcstTime == neartime {
                                    return $0.category == "T1H" ? true : false
                                }
                                return false
                            }
    
                            self.temperatureWithBookmarkedCityId[locationData.id] = Temperature(celsius: Double(resultData[0].fcstValue) ?? 0)
    
                        } catch {
                            fatalError("[초단기예보 fetching중 에러 발생] : \(error)")
                        }
                        
                        DispatchQueue.main.async {
                            self.bookmarkTableView.reloadData()
                        }
                    }
                }.resume()
            }
        }
    
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
        
        self.fetchUltraSrtData(bookmarkedCity)
        
        self.view = self.bookmarkTableView
    }
    
}


// MARK: - TableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    // section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount: Int = {
            switch tableView {
            case bookmarkTableView:
                return self.bookmarkedCity.count
            case locationSearchTableView:
                return self.isSearchActive ? self.filteredCity.count : self.allCity.count
            default:
                fatalError("TableView에 return할 cellCount가 없음")
            }
        }()
        
        return cellCount
    }
    
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case bookmarkTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell") as! BookmarkTableViewCell
            
            cell.delegate = self
            
            let currentCity = self.bookmarkedCity[indexPath.row]
            let temperature = self.temperatureWithBookmarkedCityId[currentCity.id] ?? Temperature(celsius: 0)
            
            cell.getData(
                self.isCelsius,
                currentCity,
                temperature
            )
            
            return cell
        case locationSearchTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchTableViewCell") as! LocationSearchTableViewCell
        
            let locationData = self.isSearchActive ? self.filteredCity[indexPath.row] : self.allCity[indexPath.row]
            let isBookmarked = bookmarkedCity.contains(locationData)
    
            cell.delegate = self
            cell.getData(locationData, isBookmarked)
    
            return cell
        default:
            fatalError("TableView에 return할 cell이 없음")
        }
    }
    
}


// MARK: - TableViewDelegate

extension RootViewController: UITableViewDelegate {
    
    // tab event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationData: City = {
            if tableView == self.locationSearchTableView {
                return self.isSearchActive ? self.filteredCity[indexPath.row] : self.allCity[indexPath.row]
            } else {
                return self.bookmarkedCity[indexPath.row]
            }
        }()
        let isBookmarked = bookmarkedCity.contains(locationData)
        let weatherDetailViewController = WeatherDetailViewController(locationData, self.isCelsius, isBookmarked)
        
        weatherDetailViewController.delegate = self
        
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
}


// MARK: - ButtonInteractionDelegate

extension RootViewController: ButtonInteractionDelegate {
    
    func didTabTemperatureButton(_ isCelsius: Bool) {
        self.isCelsius = isCelsius
    }
    
    func didTabBookmarkButton(_ isBookmarked: Bool, on cellData: City?) {
        if let cellData = cellData {
            switch isBookmarked {
            case true:
                if !self.bookmarkedCity.contains(cellData) {
                    self.bookmarkedCity.append(cellData)
                }
            case false:
                self.bookmarkedCity = self.bookmarkedCity.filter {
                    $0.id != cellData.id
                }
            }
        }
    
        self.locationSearchTableView.reloadData()
        self.bookmarkTableView.reloadData()
    }

}
