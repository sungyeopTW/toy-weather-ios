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
    
    private var isCelsius = true
    
    
    // MARK: - Enum
    
    enum Text {
        static let tempSubTitleText = "오늘의 최고, 최저기온"
        static let tempTitleText = "최고/최저 🌡"

        static let windSubTitleText = "바람의 풍향, 풍속"
        static let windTitleText = "바람 💨"
        
        static let rainProbabilitySubTitleText = "비가 올 확률"
        static let rainProbabilityTitleText = "강수확률 ☂️"
    }
    
    
    // MARK: - UI
    
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        $0.textColor = .black
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28.0, weight: .bold)
        $0.textColor = .black
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30.0, weight: .bold)
        $0.textColor = .black
    }
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func configureLabelText(_ subTitleValue: String, _ titleValue: String, _ contentValue: String) {
        self.subTitleLabel.text = subTitleValue
        self.titleLabel.text = titleValue
        self.contentLabel.text = contentValue
    }
    
    func updateCellWithDatas(
        _ indexPath: Int,
        _ isCelsius: Bool,
        _ weather: WeatherModel
    ) {
        // indexPath에 따라 다른 값
        switch indexPath {
        case 1:
            let format: TemperatureSymbol = isCelsius ? .celsius : .fahrenheit
            let temperatureContent = "\(weather.highestTemperature.convertWithFormat(format))"
                            + "/" + "\(weather.lowestTemperature.convertWithFormat(format))"
            
            self.configureLabelText(Text.tempSubTitleText, Text.tempTitleText, temperatureContent)
        case 2:
            let windContent = "\(weather.windDirection.rawValue) \(weather.windSpeed)"
            
            self.configureLabelText(Text.windSubTitleText, Text.windTitleText, windContent)
        case 3:
            self.configureLabelText(
                Text.rainProbabilitySubTitleText,
                Text.rainProbabilityTitleText,
                weather.rainProbability
            )
        default:
            print("CollectionViewCell의 count가 계획과 다른 에러")
        }
    }
    
}


// MARK: - Layout

extension WeatherDetailCollectionViewCell {
    
    private func setupConstraints() {
        let subViews = [self.subTitleLabel, self.titleLabel, self.contentLabel]
        subViews.forEach { self.addSubview($0) }
        
        // subTitleLabel layout
        self.subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        // // titleLabel layout
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.subTitleLabel.snp.bottom)
            $0.leading.equalTo(self.subTitleLabel)
        }
        
        // contentLabel layout
        self.contentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
}
