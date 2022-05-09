//
//  BookmarkTableViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then

final class BookmarkTableViewCell: UITableViewCell {
    
    var temperature = 16
    var location = "서울특별시 용산구 용문동"
    
    var isBookmarked = true // 즐찾 여부
    var isCelsius = true // 섭씨 여부
    
    
    // MARK: - UI
    
    private let temperatureLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 40.0, weight: .bold)
    })
    
    private let starImageView = UIImageView(frame: .zero).then({
        $0.image = UIImage(systemName: "star.fill")
    })

    private let locationLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
    })
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialize()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.temperatureLabel.text = self.isCelsius
            ? "\(self.temperature)°C"
            : "\(TemperatureHelper().functransformTemperatureToFahrenheit(self.temperature))°F"
        self.starImageView.tintColor = isBookmarked ? .yellowStarColor : .grayStarColor
        self.locationLabel.text = self.location
    }
    
    private func setupConstraints() {
        // contentView layout
        self.contentView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(80)
        })
        
        let subViews = [self.temperatureLabel, self.starImageView, self.locationLabel]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // temperatureLabel layout
        self.temperatureLabel.snp.makeConstraints({
            $0.height.equalTo(60)
            
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        })
        
        // starImageView layout
        self.starImageView.snp.makeConstraints({
            $0.width.height.equalTo(32)
        
            $0.trailing.equalTo(self.temperatureLabel.snp.trailing)
            $0.top.equalTo(self.temperatureLabel).offset(-10)
        })
        
        // locationLabel layout
        self.locationLabel.snp.makeConstraints({
            $0.trailing.equalTo(self.temperatureLabel.snp.trailing)
            $0.top.equalTo(self.starImageView.snp.bottom).offset(4)
        })
    }
    
}
