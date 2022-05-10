//
//  WeatherDetailViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailViewController: UIViewController {
    
    private let weatherDetailCollectionView = WeatherDetailCollectionView()
    
    
    // MARK: - UI
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        self.setupConstraint()
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.navigationItem.title = "날씨 상세정보 🏖"
    }
    
    private func setupConstraint() {
        self.view.addSubview(self.weatherDetailCollectionView)
        
        // weatherDetailTableView layout
        self.weatherDetailCollectionView.snp.makeConstraints({
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        })
    }
    
}
