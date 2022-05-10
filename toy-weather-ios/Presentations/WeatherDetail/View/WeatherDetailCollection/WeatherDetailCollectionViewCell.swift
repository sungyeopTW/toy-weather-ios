//
//  WeatherDetailCollectionViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class WeatherDetailCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - UI
    
    private let imageView = UIImageView().then({
        $0.contentMode = .scaleAspectFill /// 비율유지 더 작은 사이즈에 맞춤
        $0.clipsToBounds = true /// image가 imageView보다 크면 맞춰 자름
        $0.layer.cornerRadius = 12.0
        $0.backgroundColor = .gray
    })
    
    private let subTitleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 25.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let titleLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 35.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let contentLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 80.0, weight: .bold)
        $0.textColor = .white
    })
    
    private let descriptionLabel = UILabel().then({
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = .white
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
    
    func initialize() {
        // label text
        self.subTitleLabel.text = "서브 타이틀"
        self.titleLabel.text = "타이틀"
        self.contentLabel.text = "컨텐츠"
        self.descriptionLabel.text = "설명설명설명설명설명"
    }
    
    func setupConstraints() {
        let subViews = [
            self.imageView,
            self.subTitleLabel,
            self.titleLabel,
            self.contentLabel,
            self.descriptionLabel
        ]
        subViews.forEach({ self.addSubview($0) })
        
        // imageView layout
        self.imageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        // subTitleLabel layout
        self.subTitleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        })
        
        // titleLabel layout
        self.titleLabel.snp.makeConstraints({
            $0.top.equalTo(self.subTitleLabel.snp.bottom)
            $0.leading.equalTo(self.subTitleLabel)
        })
        
        // contentLabel layout
        self.contentLabel.snp.makeConstraints({
            $0.bottom.equalTo(self.descriptionLabel.snp.top).offset(-16)
            $0.trailing.equalToSuperview().offset(-32)
        })
        
        // descriptionLabel layout
        self.descriptionLabel.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-16)
            $0.leading.equalTo(self.subTitleLabel)
        })
    }
    
}
