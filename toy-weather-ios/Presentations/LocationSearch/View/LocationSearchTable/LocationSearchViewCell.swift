//
//  LocationSearchViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class LocationSearchViewCell: UITableViewCell {
    
    var location = "경기도 성남시중원구 중앙동"
    
    var isBookmarked = false // 즐찾 여부
    
    
    // MARK: - UI
    
    private let locationLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 22.0, weight: .regular)
    })
    
    private let bookmarkButton = UIButton(frame: .zero).then({
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
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
        self.locationLabel.text = self.location
        self.bookmarkButton.tintColor = self.isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
    }
    
}


// MARK: - Layout

extension LocationSearchViewCell {
    
    private func setupConstraints() {
        // contentView layout
        self.contentView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
        })
        
        let subViews = [self.locationLabel, self.bookmarkButton]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // locationLabel
        self.locationLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        })
        
        // bookmarkButton layout
        self.bookmarkButton.snp.makeConstraints({
            $0.width.height.equalTo(32)
            
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        })
    }
    
}
