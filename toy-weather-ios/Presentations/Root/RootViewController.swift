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
    
    var bookmarkCount = 3
    
    let locationSearchViewController = LocationSearchViewController()
    let weatherDetailViewController = WeatherDetailViewController()
    
    
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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        self.setupNavigationController()
    }

    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.bookmarkTableView
        
        self.locationSearchViewController.navigation = self.navigationController
    }
    
    private func setupNavigationController() {
        // NavigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white
        
        // NavigationItem
        self.navigationItem.title = Text.navigationBarTitle
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = UISearchController(
            searchResultsController: locationSearchViewController
        ).then {
            $0.searchBar.delegate = self
            $0.searchBar.placeholder = Text.searchControllerPlaceholder
            $0.hidesNavigationBarDuringPresentation = true
        }
    }
    
}


// MARK: - SearchBarDelegate

extension RootViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.bookmarkTableView.isHidden = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.bookmarkTableView.isHidden = false
    }
    
}


// MARK: - BookmarkTableViewDataSource

extension RootViewController: UITableViewDataSource {
    
    // section당 row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarkCount
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell") {
            return cell
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - BookmarkTableViewDelegate

extension RootViewController: UITableViewDelegate {
    
    // tab event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
}
