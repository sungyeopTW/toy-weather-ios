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
        
        self.setupNavigationController()
        self.setupConstraints()
    }
    
    
    // MARK: - Methods
    
    private func setupNavigationController() {
        // NavigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true /// Large Title
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.title = "오늘의 날씨 정보 🧑🏻‍💼"
        
        // SearchController
        let searchController = UISearchController().then({
            $0.searchBar.placeholder = "지역을 입력하세요 🗺"
            $0.hidesNavigationBarDuringPresentation = true

            $0.searchBar.delegate = self
        })
        self.navigationItem.searchController = searchController
    }
    
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


// MARK: - LocationSearchBarDelegate

extension LocationSearchViewController: UISearchBarDelegate {
    
    // searchBar에 입력 시작 시 locationSearchTableView -- O / bookmarkTableView -- X
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.locationSearchTableView.tableViewCellCount = 0 // row count 변경
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
