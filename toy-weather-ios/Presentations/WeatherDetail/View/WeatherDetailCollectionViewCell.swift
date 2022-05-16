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
    
    var isCelsius = true
    
    var lowestTemperature = 3.0
    var highestTemperature = 15.0
    var wind = "북서 9m/s"
    var rainProbability = "90%"
    
    
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
    
    private let subTitleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        $0.textColor = .black
    })
    
    private let titleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 28.0, weight: .bold)
        $0.textColor = .black
    })
    
    private let contentLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
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
    }
    
    func setupLabelText(indexPath: Int, isCelsius: Bool) {
        // indexPath에 따라 다른 값
        switch indexPath {
        case 1:
            self.subTitleLabel.text = Text.tempSubTitleText
            self.titleLabel.text = Text.tempTitleText
            self.contentLabel.text = isCelsius
            ? "\(self.lowestTemperature)/\(self.highestTemperature)\(Symbol.celsius)"
            : "\(TemperatureHelper.toFahrenheit( self.lowestTemperature))/\(TemperatureHelper.toFahrenheit( self.highestTemperature))\(Symbol.fahrenheit)"
        case 2:
            self.subTitleLabel.text = Text.windSubTitleText
            self.titleLabel.text = Text.windTitleText
            self.contentLabel.text = self.wind
        default:
            self.subTitleLabel.text = Text.rainProbabilitySubTitleText
            self.titleLabel.text = Text.rainProbabilityTitleText
            self.contentLabel.text = self.rainProbability
        }
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
