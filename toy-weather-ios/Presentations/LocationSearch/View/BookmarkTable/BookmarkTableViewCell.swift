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
    
    private let temperatureButton = UIButton().then({
        $0.titleLabel?.font = .systemFont(ofSize: 45.0, weight: .bold)
        $0.setTitleColor(.black, for: .normal)
    })
    
    private let bookmarkButton = UIButton(frame: .zero).then({
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
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
        // label
        self.locationLabel.text = self.location
        
        // temperatureButton
        self.temperatureButton.setTitle(
            self.isCelsius
                ? "\(self.temperature)°C"
                : "\(TemperatureHelper().functransformTemperatureToFahrenheit(self.temperature))°F",
            for: .normal
        )
        self.temperatureButton.addTarget(
            self,
            action: #selector(tabTemperatureButton(_:)),
            for: .touchUpInside
        )
        
        // bookmarkButton
        self.bookmarkButton.tintColor = self.isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
    }
    
    // tabTemperatureButton
    @objc func tabTemperatureButton(_ sender: UIButton) {
        self.isCelsius = !self.isCelsius
        print(self.isCelsius)
    }
    
}


// MARK: - Layout

extension BookmarkTableViewCell {
    
    private func setupConstraints() {
        // contentView layout
        self.contentView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(80)
        })
        
        let subViews = [self.temperatureButton, self.bookmarkButton, self.locationLabel]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // temperatureLabel layout
        self.temperatureButton.snp.makeConstraints({
            $0.height.equalTo(60)
            
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
        })
        
        // bookmarkButton layout
        self.bookmarkButton.snp.makeConstraints({
            $0.width.height.equalTo(32)
            
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(self.temperatureButton).offset(-10)
        })
        
        // locationLabel layout
        self.locationLabel.snp.makeConstraints({
            $0.trailing.equalTo(self.bookmarkButton.snp.trailing)
            $0.top.equalTo(self.bookmarkButton.snp.bottom).offset(4)
        })
    }
    
}
