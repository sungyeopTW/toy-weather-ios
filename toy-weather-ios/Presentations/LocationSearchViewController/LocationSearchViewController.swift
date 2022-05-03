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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationController setting
        self.setNavigationController()
        
    }
    
    
    // MARK: - Methods
    
    func setNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true /// Large Title
        self.navigationItem.title = "오늘의 날씨 정보 👩🏻‍💼"
        
        // UISearchController
        let searchController = UISearchController().then({
            $0.searchBar.placeholder = "지역을 입력하세요 🗺"
        })
        self.navigationItem.searchController = searchController
    }
    
}
