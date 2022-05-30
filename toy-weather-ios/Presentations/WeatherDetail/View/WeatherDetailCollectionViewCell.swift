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
    
    private var lowestTemperature = Temperature(celsius: 3.0)
    private var highestTemperature = Temperature(celsius: 15.0)
    private var wind = "북서 9m/s"
    private var rainProbability = "90%"
    
    
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
    
    func setupLabelText(_ indexPath: Int, _ isCelsius: Bool) {
        // indexPath에 따라 다른 값
        switch indexPath {
        case 1:
            let format: TemperatureSymbol = isCelsius ? .celsius : .fahrenheit
            let contentValue = "\(self.lowestTemperature.convertWithFormat(format))" + "/" +
                               "\(self.highestTemperature.convertWithFormat(format))"
            
            self.configureLabelText(Text.tempSubTitleText, Text.tempTitleText, contentValue)
        case 2:
            self.configureLabelText(Text.windSubTitleText, Text.windTitleText, self.wind)
        case 3:
            self.configureLabelText(Text.rainProbabilitySubTitleText, Text.rainProbabilityTitleText, self.rainProbability)
        default:
            fatalError("CollectionViewCell의 count가 계획과 다름")
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
