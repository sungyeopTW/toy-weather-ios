//
//  WeatherDetailTableViewCell.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/06/16.
//

import UIKit

import RxSwift

import SnapKit
import Then

final class WeatherDetailView: UIScrollView {
    
    var disposeBag = DisposeBag()
    
    // MARK: - Enum
    
    enum DetailSubject: String {
        case temperatureSubject = "최고, 최저 🌡"
        case windSubject = "풍향, 풍속 💨"
        case rainProbabilitySubject = "강수확률 ☂️"
    }
    
    
    // MARK: - UI
        
    let contentView = UIView()
    
    var backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill /// 비율유지 더 작은 사이즈에 맞춤
        $0.clipsToBounds = true /// image가 imageView보다 크면 맞춰 자름
        $0.layer.cornerRadius = 12.0
    }
    
    var bookmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star.fill"), for: .normal)
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
    }

    var skyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 60.0, weight: .bold)
        $0.textColor = .white
    }

    var temperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 60.0, weight: .bold)
        $0.textColor = .white
    }
    
    var highestLowestsubjectLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
        $0.text = DetailSubject.temperatureSubject.rawValue
    }

    var highestLowestLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
    }
    
    var windsubjectLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
        $0.text = DetailSubject.windSubject.rawValue
    }

    var windLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
    }
    
    var rainProbabilitySubjectLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
        $0.text = DetailSubject.rainProbabilitySubject.rawValue
    }

    var rainProbabilityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32.0, weight: .bold)
        $0.textColor = .black
    }
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alwaysBounceVertical = true
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Layout

extension WeatherDetailView {
    
    private func setupConstraints() {
        // contentView
        self.addSubview(contentView)
        
        self.contentView.snp.makeConstraints {
            $0.edges.width.equalTo(self)
        }
        
        // items
        let subViews = [
            self.backgroundImageView,
            self.bookmarkButton,
            self.skyLabel,
            self.temperatureLabel,
            self.highestLowestsubjectLabel,
            self.highestLowestLabel,
            self.windsubjectLabel,
            self.windLabel,
            self.rainProbabilitySubjectLabel,
            self.rainProbabilityLabel
        ]
        subViews.forEach { self.contentView.addSubview($0) }
        
        // backgroundImageView layout
        self.backgroundImageView.snp.makeConstraints {
            $0.width.equalToSuperview().inset(16)
            $0.height.equalTo(self.snp.width).inset(16)

            $0.top.leading.equalToSuperview().offset(16)
        }
        
        self.bookmarkButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            
            $0.top.equalToSuperview().inset(36)
            // $0.trailing.equalToSuperview().inset(36) /// ?? 왜 이건 이벤트가 안먹는지..?
            $0.center.equalToSuperview()
        }
        
        // skyLabel layout
        self.skyLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.temperatureLabel.snp.top)
            $0.leading.equalTo(self.temperatureLabel.snp.leading)
        }

        // temperatureButton layout
        self.temperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.backgroundImageView.snp.bottom).inset(24)
            $0.leading.equalTo(self.backgroundImageView.snp.leading).inset(30)
        }
        
        // highestLowestsubjectLabel layout
        self.highestLowestsubjectLabel.snp.makeConstraints {
            $0.top.equalTo(self.backgroundImageView.snp.bottom).offset(25)
            $0.leading.equalTo(self.backgroundImageView.snp.leading).inset(15)
        }
        
        // highestLowestLabel layout
        self.highestLowestLabel.snp.makeConstraints {
            $0.top.equalTo(self.highestLowestsubjectLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(self.backgroundImageView.snp.trailing).inset(15)
        }
        
        // windsubjectLabel layout
        self.windsubjectLabel.snp.makeConstraints {
            $0.top.equalTo(self.highestLowestLabel.snp.bottom).offset(25)
            $0.leading.equalTo(self.backgroundImageView.snp.leading).inset(15)
        }
        
        // windLabel layout
        self.windLabel.snp.makeConstraints {
            $0.top.equalTo(self.windsubjectLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(self.backgroundImageView.snp.trailing).inset(15)
        }
        
        // windsubjectLabel layout
        self.rainProbabilitySubjectLabel.snp.makeConstraints {
            $0.top.equalTo(self.windLabel.snp.bottom).offset(25)
            $0.leading.equalTo(self.backgroundImageView.snp.leading).inset(15)
        }
        
        // windLabel layout
        self.rainProbabilityLabel.snp.makeConstraints {
            $0.top.equalTo(self.rainProbabilitySubjectLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(self.backgroundImageView.snp.trailing).inset(15)
        }
        
        
    }
    
}
