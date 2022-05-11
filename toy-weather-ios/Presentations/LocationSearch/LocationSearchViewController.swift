//
//  LocationSearchViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then

final class LocationSearchViewController: UIViewController {
    
    private let locationSearchTableView = LocationSearchTableView()
    private let bookmarkTableView = BookmarkTableView()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        self.setupNavigationController()
        self.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.setupNavigationController()
        self.setupConstraints()
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        // navigationController 넘김
        self.bookmarkTableView.navigation = self.navigationController
        self.locationSearchTableView.navigation = self.navigationController
    }
    
    private func setupNavigationController() {
        // NavigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .systemBackground

        // SearchController
        let searchController = UISearchController().then({
            $0.searchBar.placeholder = "지역을 입력하세요 🗺"
            $0.hidesNavigationBarDuringPresentation = true
            $0.searchBar.delegate = self
        })
        
        // NavigationItem
        self.navigationItem.title = "오늘의 날씨 정보 🧑🏻‍💼"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
}


// MARK: - LocationSearchBarDelegate

extension LocationSearchViewController: UISearchBarDelegate {
    
    // searchBar에 입력 시작 시 locationSearchTableView -- O / bookmarkTableView -- X
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.locationSearchTableView.tableViewCellCount = 10 // row count 변경
        self.locationSearchTableView.reloadData() // reload
        self.locationSearchTableView.isHidden = false // 숨김 여부
        
        self.bookmarkTableView.isHidden = true
    }
    
    // searchBar에 입력 종료 시 locationSearchTableView -- X / bookmarkTableView -- O
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.locationSearchTableView.isHidden = true
        
        self.bookmarkTableView.tableViewCellCount = 5
        self.bookmarkTableView.reloadData()
        self.bookmarkTableView.isHidden = false
    }
    
}


// MARK: - Layout

extension LocationSearchViewController {
    
    private func setupConstraints() {
        let subViews = [self.bookmarkTableView, self.locationSearchTableView]
        subViews.forEach{ self.view.addSubview($0) }
        
        // bookmarkTableView layout
        self.bookmarkTableView.snp.makeConstraints({
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        // locationSearchTableView layout
        self.locationSearchTableView.snp.makeConstraints({
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        })
    }
    
}
