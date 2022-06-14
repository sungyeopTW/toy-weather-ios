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
    
    weak var delegate: ButtonInteractionDelegate?
    
    var disposeBag = DisposeBag()
    
    // var test: City?
    
    // private var bookmarkedCellData: City?
    // private var isCelsius = true // 섭씨 여부
    
    
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
        
        self.initialize()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        // selectionStyle
        self.selectionStyle = .none
            
        // bookmarkButton
        // self.bookmarkButton.addTarget(self, action: #selector(tabBookmarkButton(_:)), for: .touchUpInside)
    }
    
    func updateCellWithDatas(
        _ isCelsius: Bool,
        _ locationData: City,
        _ temperature: Temperature
    ) {
        // data
        // self.bookmarkedCellData = locationData
        
        // label
        // self.temperatureLabel.text = temperature.convertWithFormat(isCelsius ? .celsius : .fahrenheit)
    }
    
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        // self.delegate?.didTabBookmarkButton(false, on: self.bookmarkedCellData!)
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
