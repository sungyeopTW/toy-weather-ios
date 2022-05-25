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
    
    weak var delegate: SendDataFromTableViewCell?
    
    private var locationCellData: City = []
    private var isBookmarked = false // 즐찾 여부
    
    
    // MARK: - UI
    
    private let locationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18.0, weight: .regular)
    }
    
    private let bookmarkButton = UIButton(frame: .zero).then {
        $0.setImage(UIImage(systemName: Image.bookmark), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
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
        self.bookmarkButton.addTarget(self, action: #selector(tabBookmarkButton), for: .touchUpInside)
    }
    
    func getData(_ locationData: City, _ isBookmarked: Bool) {
        // data
        self.locationCellData = locationData
        
        // label
        self.locationLabel.text = locationData.location
        
        // isBookmark
        self.isBookmarked = isBookmarked
        
        // bookmarkButton
        self.bookmarkButton.tintColor = self.isBookmarked ? .yellowBookmarkColor : .grayBookmarkColor
    }
    
    // tabBookmarkButton
    @objc func tabBookmarkButton(_ sender: UIButton) {
        self.isBookmarked.toggle()
        self.delegate?.sendIsBookmarked(self.isBookmarked, self.locationCellData)
    }
    
}


// MARK: - Layout

extension LocationSearchTableViewCell {
    
    private func setupConstraints() {
        let subViews = [self.locationLabel, self.bookmarkButton]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // locationLabel
        self.locationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        // bookmarkButton layout
        self.bookmarkButton.snp.makeConstraints {
            $0.width.height.equalTo(35)
            
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }
    
}
