//
//  EmptyBookmarkView.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/15.
//

import UIKit

import SnapKit
import Then

final class EmptyBookmarkView: UIView {
    
    let descriptionText: String = "지역을 검색한 뒤 \n즐겨찾기를 추가하세요⭐️"
    
    
    // MARK: - UI
    
    private let descriptionLabel = UILabel().then({
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
        $0.textColor = .gray
        $0.textAlignment = .center
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
        self.descriptionLabel.text = self.descriptionText
    }
    
}


// MARK: - Layout

extension EmptyBookmarkView {
    private func setupConstraints() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        
        self.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
    }
}
