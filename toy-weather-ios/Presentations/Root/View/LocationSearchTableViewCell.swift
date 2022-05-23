//
//  LocationSearchTableViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class LocationSearchTableViewCell: UITableViewCell {
    
    var location = ""
    
    var isBookmarked = false // 즐찾 여부
    
    
    // MARK: - UI
    
    private let locationLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 22.0, weight: .regular)
    })
    
    private let bookmarkButton = UIButton(frame: .zero).then({
        $0.setImage(UIImage(systemName: Image.bookmark), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    })
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    func initialize(_ locationData: [String]) {
        // selectionStyle
        self.selectionStyle = .none
        
        // label
        self.locationLabel.text = "\(locationData[0])"
        
        // bookmarkButton
        self.bookmarkButton.tintColor = self.isBookmarked
            ? .yellowBookmarkColor
            : .grayBookmarkColor
        self.bookmarkButton.addTarget(
            self,
            action: #selector(tabBookmarkButton),
            for: .touchUpInside
        )
    }
    
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        self.isBookmarked.toggle()
        print("isBookmarked : ", self.isBookmarked)
    }
    
}


// MARK: - Layout

extension LocationSearchTableViewCell {
    
    private func setupConstraints() {
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
