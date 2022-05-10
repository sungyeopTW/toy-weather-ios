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
        
        // TODO: 추후 identifier 첫문자 대문자로 싹--- 바꿉시당
        self.register(
            WeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: "weatherDetailCollectionViewCell"
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
        5
    }
    
    // cell
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "weatherDetailCollectionViewCell",
            for: indexPath
        ) as? WeatherDetailCollectionViewCell
        
        else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

// layout으로 flowLayout을 사용했으므로
extension WeatherDetailCollectionView: UICollectionViewDelegateFlowLayout {
    
    // item size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32.0
    
        return CGSize(width: width, height: width)
    }
    
}
