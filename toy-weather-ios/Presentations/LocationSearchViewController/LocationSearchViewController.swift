//
//  LocationSearchViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then

class LocationSearchViewController: UIViewController {
    
    private let locationSearchTableView = LocationSearchTableView()
    private let bookmarkTableView = BookmarkTableView()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationController() /// Setting -- NavigationController
        
        self.setBookmarkTableViewLayout() /// Layout -- BookmarkTableView
        self.setLocationSearchTableViewLayout() /// Layout -- LocationSearchTableView
    }
    
    
    // MARK: - Methods
    
    private func setNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true /// Large Title
        self.navigationItem.title = "오늘의 날씨 정보 🧑🏻‍💼"
        
        // UISearchController
        let searchController = UISearchController().then({
            $0.searchBar.placeholder = "지역을 입력하세요 🗺"
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchBar.delegate = self
        })
        self.navigationItem.searchController = searchController
    }
    
}


// MARK: - Layout

extension LocationSearchViewController {
    
    private func setBookmarkTableViewLayout() {
        self.view.addSubview(bookmarkTableView)
        bookmarkTableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    private func setLocationSearchTableViewLayout() {
        self.view.addSubview(locationSearchTableView)
        locationSearchTableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
}


// MARK: - LocationSearchBarDelegate

extension LocationSearchViewController: UISearchBarDelegate {
    
    // searchBar에 입력 시작 시 locationSearchTableView -- O / bookmarkTableView -- X
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.locationSearchTableView.tableViewCellCount = 10 // row count 변경
        self.locationSearchTableView.reloadData() // reload
        self.locationSearchTableView.isHidden = false // 보이게
        
        self.bookmarkTableView.tableViewCellCount = 0
        self.bookmarkTableView.reloadData()
        self.bookmarkTableView.isHidden = true
    }
    
    // searchBar에 입력 종료 시 locationSearchTableView -- X / bookmarkTableView -- O
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.locationSearchTableView.tableViewCellCount = 0
        self.locationSearchTableView.reloadData()
        self.locationSearchTableView.isHidden = true
        
        self.bookmarkTableView.tableViewCellCount = 10
        self.bookmarkTableView.reloadData()
        self.bookmarkTableView.isHidden = false
    }
    
}
