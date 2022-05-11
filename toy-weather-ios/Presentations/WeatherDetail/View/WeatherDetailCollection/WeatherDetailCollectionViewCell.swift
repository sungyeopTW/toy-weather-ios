//
//  WeatherDetailCollectionViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailCollectionViewCell: UICollectionViewCell {
    
    var index: Int?
    
    var subTitleText = "바람의 풍향, 풍속"
    var titleLabelText = "바람 💨"
    var contentLabelText = "컨텐츠"
    
    
    // MARK: - UI
    
    private let subTitleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        $0.textColor = .black
    })
    
    private let titleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 28.0, weight: .bold)
        $0.textColor = .black
    })
    
    private let contentLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 40.0, weight: .bold)
        $0.textColor = .black
    })
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        // just bottom border
        self.layer.addBorder([.bottom], color: .grayBorderColor, width: 1.0)
        
        // label text
        self.subTitleLabel.text = self.subTitleText
        self.titleLabel.text = self.titleLabelText
        self.contentLabel.text = self.contentLabelText
    }
    
}


// MARK: - Layout

extension WeatherDetailCollectionViewCell {
    
    private func setupConstraints() {
        let subViews = [self.subTitleLabel, self.titleLabel, self.contentLabel]
        subViews.forEach({ self.addSubview($0) })
        
        // subTitleLabel layout
        self.subTitleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        })
        
        // // titleLabel layout
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(self.subTitleLabel.snp.bottom)
            $0.leading.equalTo(self.subTitleLabel)
        })
        
        // contentLabel layout
        self.contentLabel.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
        })
    }
    
}
