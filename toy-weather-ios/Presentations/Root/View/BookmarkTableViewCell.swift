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
    
    var temperature: Celsius = 16.0
    var location = "서울특별시 용산구 용문동"
    
    var isBookmarked = true // 즐찾 여부
    var isCelsius = true // 섭씨 여부
    
    
    // MARK: - UI
    private let temperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40.0, weight: .bold)
    }
    
    private let bookmarkButton = UIButton(frame: .zero).then {
        $0.setImage(UIImage(systemName: Image.bookmark), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    }

    private let locationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
    }
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func initialize(_ isCelsius: Bool) {
        // selectionStyle
        self.selectionStyle = .none
        
        // label
        self.locationLabel.text = self.location
        self.temperatureLabel.text = self.temperature.convertWithFormat(isCelsius ? .celsius : .fahrenheit)
            
        
        // bookmarkButton
        self.bookmarkButton.tintColor = self.isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
        self.bookmarkButton.addTarget(
            self,
            action: #selector(tabBookmarkButton(_:)),
            for: .touchUpInside)
    }
    
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        self.isBookmarked.toggle()
        print("isBookmarked : ", self.isBookmarked)
    }
    
}


// MARK: - Layout

extension BookmarkTableViewCell {
    
    private func setupConstraints() {
        let subViews = [self.temperatureLabel, self.bookmarkButton, self.locationLabel]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // temperatureLabel layout
        self.temperatureLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
        }
        
        // bookmarkButton layout
        self.bookmarkButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
            
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(self.temperatureLabel).offset(-10)
        }
        
        // locationLabel layout
        self.locationLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.bookmarkButton.snp.trailing)
            $0.top.equalTo(self.bookmarkButton.snp.bottom).offset(4)
        }
    }
    
}
