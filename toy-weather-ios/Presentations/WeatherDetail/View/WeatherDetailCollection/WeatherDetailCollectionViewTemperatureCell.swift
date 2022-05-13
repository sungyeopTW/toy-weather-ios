//
//  WeatherDetailCollectionViewFirstCell
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailCollectionViewTemperatureCell: UICollectionViewCell {
    
    var subTitle = "기온 및 기상상황"
    var title = "기온"
    var sky = "비"
    var temperature = 9
    
    var isBookmarked = true // 즐찾 여부
    var isCelsius = true // 섭씨 여부
    
    
    // MARK: - UI
    
    private let backgroundImageView = UIImageView().then({
        $0.contentMode = .scaleAspectFill /// 비율유지 더 작은 사이즈에 맞춤
        $0.clipsToBounds = true /// image가 imageView보다 크면 맞춰 자름
        $0.layer.cornerRadius = 12.0
        $0.image = UIImage(named: "rain") /// 날씨에 따라 이미지 변경
    })
    
    private let subTitleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let titleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 45.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let bookmarkButton = UIButton(frame: .zero).then({
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    })
    
    private let skyLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 45.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let temperatureButton = UIButton().then({
        $0.titleLabel?.font = .systemFont(ofSize: 70.0, weight: .bold)
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
        // label
        self.subTitleLabel.text = self.subTitle
        self.titleLabel.text = self.title
        self.skyLabel.text = self.sky
        
        // bookmarkButton
        self.bookmarkButton.tintColor = self.isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
        self.bookmarkButton.addTarget(
            self,
            action: #selector(tabBookmarkButton),
            for: .touchUpInside)
        
        // temperatureButton
        // self.temperatureButton.setTitle(
        //     self.isCelsius
        //         ? "\(self.temperature)°C"
        //         : "\(TemperatureHelper().transformTemperatureToFahrenheit(self.temperature))°F",
        //     for: .normal
        // )
        self.temperatureButton.addTarget(
            self,
            action: #selector(tabTemperatureButton(_:)),
            for: .touchUpInside
        )
    }
    
    // tabTemperatureButton
    @objc func tabTemperatureButton(_ sender: UIButton) {
        self.isCelsius = !self.isCelsius
        print("isCelsius : ", self.isCelsius)
    }
    
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        self.isBookmarked = !self.isBookmarked
        print("isBookmarked : ", self.isBookmarked)
    }
    
}


// MARK: - Layout

extension WeatherDetailCollectionViewTemperatureCell {
    
    private func setupConstraints() {
        let subViews = [
            self.backgroundImageView,
            self.subTitleLabel,
            self.titleLabel,
            self.bookmarkButton,
            self.skyLabel,
            self.temperatureButton
        ]
        subViews.forEach({ self.addSubview($0) })
        
        // imageView layout
        self.backgroundImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        // subTitleLabel layout
        self.subTitleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(32)
        })
        
        // titleLabel layout
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(self.subTitleLabel.snp.bottom)
            $0.leading.equalTo(self.subTitleLabel)
        })
        
        // bookmarkButton layout
        self.bookmarkButton.snp.makeConstraints({
            $0.width.height.equalTo(45)
            
            $0.top.equalTo(self.subTitleLabel.snp.top)
            $0.trailing.equalTo(self.skyLabel.snp.trailing)
        })
        
        // skyLabel layout
        self.skyLabel.snp.makeConstraints({
            $0.bottom.equalTo(self.temperatureButton.snp.top).offset(10)
            $0.trailing.equalToSuperview().offset(-34)
        })
        
        // temperatureButton layout
        self.temperatureButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalTo(self.skyLabel).offset(2)
        })
    }
    
}
