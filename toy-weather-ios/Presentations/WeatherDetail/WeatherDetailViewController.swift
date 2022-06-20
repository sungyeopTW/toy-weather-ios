//
//  WeatherDetailViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import ReactorKit

import SnapKit
import Then


final class WeatherDetailViewController: UIViewController, ReactorKit.View {
    
    var disposeBag = DisposeBag()
    var isCelsius: Bool = UserDefaultsManager.loadIsCelsius()
    
    private var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
    }

    private lazy var backButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "arrow.backward")
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabBackButton)
    }

    private lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "thermometer")
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tapThermometerButton)
    }
    
    private var weatherDetailView = WeatherDetailView()

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.weatherDetailView
        self.view.backgroundColor = .white
        reactor?.action.onNext(.landing)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationController()
    }
    
    
    // MARK: - Bind
    
    func bind(reactor: WeatherDetailViewReactor) {
        // [weatherDetailView] 즐겨찾기 버튼
        self.weatherDetailView.bookmarkButton.rx.tap
            .map { _ in Reactor.Action.bookmark(reactor.currentState.city.id) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // [WeatherDetailViewController] bind with `city`
        reactor.state.map(\.city.location)
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        // reactor.state.map { $0.city.location }
        //     .withUnretained(self)
        //     .subscribe(onNext: { object, location in
        //         object.titleLabel.text = location
        //     })
        //     .disposed(by: self.disposeBag)
        
        // [WeatherDetailView] bind with `city`
        reactor.state.map { $0.city }
            .withUnretained(self)
            .subscribe(onNext: { object, city in
                let view = object.weatherDetailView
                let weather = city.weather
                let isCelsius = object.isCelsius ? TemperatureSymbol.celsius : .fahrenheit
                
                view.backgroundImageView.image = UIImage(named: object.backGroundImageName(Sky(rawValue: weather.sky.rawValue)!))
                view.bookmarkButton.tintColor = city.isBookmarked ? .yellowBookmarkColor : .grayBookmarkColor
                view.skyLabel.text = weather.sky.rawValue
                view.temperatureLabel.text = weather.currentTemperature.convertWithFormat(isCelsius)
                view.highestLowestLabel.text = "\(weather.highestTemperature.convertWithFormat(isCelsius)), \(weather.lowestTemperature.convertWithFormat(isCelsius))"
                view.windLabel.text = "\(weather.windDirection.rawValue), \(weather.windSpeed)"
                view.rainProbabilityLabel.text = weather.rainProbability
            })
            .disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Methods
    
    private func setupNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.titleView = self.titleLabel
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.thermometerButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc func tabBackButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()

        UserDefaultsManager.saveIsCelsius(self.isCelsius) /// userDefault에 저장
        reactor?.action.onNext(.refresh)
    }
    
    private func backGroundImageName(_ sky: Sky) -> String {
        switch sky {
        case .initial:
            return "whiteBg"
        case .sunny:
            return "sunny"
        case .clouds:
            return "clouds"
        case .rain:
            return "rain"
        case .snow:
            return "snow"
        }
    }
    
}


// MARK: - UIGestureRecognizerDelegate

extension WeatherDetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
