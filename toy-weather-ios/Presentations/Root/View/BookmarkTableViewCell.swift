//
//  BookmarkTableViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import RxSwift

import SnapKit
import Then


final class BookmarkTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    
    // MARK: - UI
    
    let temperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 38.0, weight: .bold)
    }
    
    let bookmarkButton = UIButton(frame: .zero).then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = .yellowBookmarkColor
    }

    let locationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .regular)
    }
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            $0.width.height.equalTo(35)
            
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
