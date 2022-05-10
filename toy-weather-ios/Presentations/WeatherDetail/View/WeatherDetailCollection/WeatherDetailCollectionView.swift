//
//  WeatherDetailCollectionView.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailCollectionView: UICollectionView {
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.dataSource = self
        self.delegate = self
        
        self.register(
            WeatherDetailCollectionViewTemperatureCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell"
        )
        self.register(
            WeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell"
        )
    }

}


// MARK: - WeatherDetailCollectionViewDataSource

extension WeatherDetailCollectionView: UICollectionViewDataSource {
    
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


// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherDetailCollectionView: UICollectionViewDelegateFlowLayout {
    
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
