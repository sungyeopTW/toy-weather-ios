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

    
    // MARK: - Enum
    
    enum Text {
        static let navigationBarTitle = "날씨 상세정보 🏖"
    }
    
    
    // MARK: - UI
    lazy var weatherDetailCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(
            WeatherDetailCollectionViewTemperatureCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell"
        )
        $0.register(
            WeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell"
        )
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.weatherDetailCollectionView
        
        self.navigationItem.title = Text.navigationBarTitle
    }
        
}


// MARK: - WeatherDetailCollectionViewDataSource

extension WeatherDetailViewController: UICollectionViewDataSource {
    
    // section 별 item 수
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }
    
    // cell
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: indexPath[1] == 0
                ? "WeatherDetailCollectionViewTemperatureCell"
                : "WeatherDetailCollectionViewCell",
            for: indexPath
        )
        
        return cell
    }

}


// MARK: - WeatherDetailCollectionViewDelegateFlowLayout

extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout {
    
    // item size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32.0
    
        return CGSize(width: width, height: indexPath[1] == 0 ? width : 120)
    }
    
}
