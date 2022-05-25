//
//  WeatherDetailCollectionViewFirstCell
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/10.
//

import UIKit

import SnapKit
import Then


// MARK: - SendDataFromWeatherDetailCollectionViewCell

protocol SendDataFromWeatherDetailCollectionViewCell: AnyObject {
    
    func sendIsBookmarked(_ isBookmarked: Bool)
    
}


final class WeatherDetailCollectionViewTemperatureCell: UICollectionViewCell {
    
    weak var delegate: SendDataFromWeatherDetailCollectionViewCell?
    
    private var isBookmarked = true // 즐찾 여부
    private var isCelsius = true // 섭씨 여부
    
    private var sky = "비"
    private var temperature = 9.0
    
    
    // MARK: - Enum
    
    enum Text {
        static let subTitle = "기온 및 기상상황"
        static let title = "기온"
    }
    
    
    // MARK: - UI
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill /// 비율유지 더 작은 사이즈에 맞춤
        $0.clipsToBounds = true /// image가 imageView보다 크면 맞춰 자름
        $0.layer.cornerRadius = 12.0
        $0.image = UIImage(named: Image.rain) /// 날씨에 따라 이미지 변경
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        $0.textColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 45.0, weight: .bold)
        $0.textColor = .white
    }
    
    private let bookmarkButton = UIButton(frame: .zero).then {
        $0.setImage(UIImage(systemName: Image.bookmark), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    private let skyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 45.0, weight: .bold)
        $0.textColor = .white
    }
    
    private let temperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 70.0, weight: .bold)
        $0.textColor = .white
    }
    
    
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
        self.subTitleLabel.text = Text.subTitle
        self.titleLabel.text = Text.title
        self.skyLabel.text = self.sky
        
        // bookmarkButton
        self.bookmarkButton.addTarget(
            self,
            action: #selector(tabBookmarkButton),
            for: .touchUpInside)
    }
    
    func getData(isCelsius: Bool, isBookmarked: Bool) {
        self.isCelsius = isCelsius
        self.isBookmarked = isBookmarked
        
        // bookmarkButton
        self.bookmarkButton.tintColor = isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
        
        // temperatureButton
        self.temperatureLabel.text = self.temperature.convertWithFormat(isCelsius ? .celsius : .fahrenheit)
    }
        
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        self.isBookmarked.toggle()
        
        self.delegate?.sendIsBookmarked(self.isBookmarked)
    }
    
}


// MARK: - Layout

extension WeatherDetailCollectionViewTemperatureCell {
    
    private func setupConstraints() {
        let subViews = [
            self.imageView,
            self.subTitleLabel,
            self.titleLabel,
            self.bookmarkButton,
            self.skyLabel,
            self.temperatureLabel
        ]
        subViews.forEach({ self.addSubview($0) })
        
        // imageView layout
        self.imageView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(self.snp.width)
            
            $0.top.equalToSuperview().offset(32)
        })
        
        // subTitleLabel layout
        self.subTitleLabel.snp.makeConstraints({
            $0.top.equalTo(self.imageView.snp.top).offset(32)
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
            $0.bottom.equalTo(self.temperatureLabel.snp.top).offset(10)
            $0.trailing.equalToSuperview().offset(-34)
        })
        
        // temperatureButton layout
        self.temperatureLabel.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalTo(self.skyLabel).offset(2)
        })
    }
    
}
