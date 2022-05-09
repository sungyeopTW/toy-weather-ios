//
//  LocationSearchViewEmptyCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/09.
//

import UIKit

import SnapKit
import Then

final class LocationSearchViewEmptyCell: UITableViewCell {
    
    let descriptionText: String = "해당하는 지역이 없습니다."
    
    
    // MARK: - UI
    
    private let descriptionLabel = UILabel().then({
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20.0, weight: .regular)
        $0.textColor = .gray
        $0.textAlignment = .center
    })
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupInitialValue()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    
    private func setupInitialValue() {
        self.descriptionLabel.text = self.descriptionText
    }
    
    private func setupConstraints() {
        // contentView layout
        self.contentView.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(150)
        })
        
        self.contentView.addSubview(self.descriptionLabel)
        
        // descriptionLabel layout
        self.descriptionLabel.snp.makeConstraints({
            $0.height.equalToSuperview()
            
            $0.center.equalToSuperview()
        })
    }

}
