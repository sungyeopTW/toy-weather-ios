//
//  WeatherDetailViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then


final class WeatherDetailViewController: UIViewController {
    
    weak var delegate: ButtonInteractionDelegate?
    
    var locationData: City
    var weatherData: [WeatherItem] = []
    
    var isCelsius = true
    var isBookmarked = false
    
    private var sky: Sky = .initial /// 하늘상태
    private var temperature: [String: Temperature] = [
        "current": Temperature(celsius: 0), /// 현재기온
        "highest": Temperature(celsius: 0), /// 최고기온
        "lowest": Temperature(celsius: 0) /// 최저기온
    ]
    private var wind: (Compass, Int) = (.initial, 0) /// (풍향, 풍속)
    private var rainProbability: String = "" /// 강수확률
    
    
    // MARK: - Life Cycle
    
    init(_ locationData: City, _ isCelsius: Bool, _ isBookmarked: Bool) {
        self.locationData = locationData
        self.isCelsius = isCelsius
        self.isBookmarked = isBookmarked
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        
        self.fetchUltraSrtData()
        self.fetchVilageData()
    }
    
    
    // MARK: - UI
    private lazy var weatherDetailCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(
            WeatherDetailCollectionViewTemperatureCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell"
        )
        $0.register(
            WeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell"
        )
    }
    
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
        $0.action = #selector(tabThermometerButton)
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.weatherDetailCollectionView
        
        self.titleLabel.text = self.locationData.location
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.titleView = self.titleLabel
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.thermometerButton
        
        self.weatherDetailCollectionView.reloadData()
    }
    
    // 초단기예보 -- for 강수형태, 하늘상태, 현재기온, 풍향, 풍속
    private func fetchUltraSrtData() {
        WeatherManager.fetchWeatherDetailUltraSrtData(self.locationData) { [weak self] temperature, sky, windDirection, windSpeed in
            self?.temperature["current"] = temperature
            self?.sky = sky
            self?.wind = (windDirection, windSpeed)
        
            DispatchQueue.main.async {
                self?.weatherDetailCollectionView.reloadData()
            }
        }
    }
    
    // 단기예보 -- for 최저기온, 최고기온, 강수확률
    private func fetchVilageData() {
        WeatherManager.fetchWeatherDetailVilageData(self.locationData) { [weak self] highestTemperature, lowestTemperature, rainProbability in
            self?.temperature["highest"] = highestTemperature
            self?.temperature["lowest"] = lowestTemperature
            self?.rainProbability = rainProbability
            
            DispatchQueue.main.async {
                self?.weatherDetailCollectionView.reloadData()
            }
        }
    }
    
    @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()
        self.weatherDetailCollectionView.reloadData()
    }
    
    @objc func tabBackButton(_ sender: UIBarButtonItem) {
        self.delegate?.didTabTemperatureButton(self.isCelsius)
        self.delegate?.didTabBookmarkButton(self.isBookmarked, on: self.locationData)
        
        self.navigationController?.popViewController(animated: true)
    }
        
}


// MARK: - WeatherDetailCollectionViewDataSource

extension WeatherDetailViewController: UICollectionViewDataSource {
    
    // section 별 item 수
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }
    
    // cell
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell",
                for: indexPath
            ) as! WeatherDetailCollectionViewTemperatureCell
            
            cell.delegate = self
            cell.updateCellWithDatas(
                self.isCelsius,
                self.isBookmarked,
                self.temperature["current"]!,
                self.sky
            )
        
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WeatherDetailCollectionViewCell",
                for: indexPath
            ) as! WeatherDetailCollectionViewCell
            
            cell.updateCellWithDatas(
                indexPath.row,
                self.isCelsius,
                self.temperature,
                self.wind,
                self.rainProbability
            )
    
            return cell
        }
    }

}


// MARK: - WeatherDetailCollectionViewDelegateFlowLayout

extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout {
    
    // item size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width - 32.0
    
        return CGSize(width: width, height: indexPath.row == 0 ? width + 32 : 120)
    }
    
}


// MARK: - ButtonInteractionDelegate

extension WeatherDetailViewController: ButtonInteractionDelegate {
    
    func didTabBookmarkButton(_ isBookmarked: Bool, on cellData: City?) {
        self.isBookmarked = isBookmarked
    
        self.weatherDetailCollectionView.reloadData()
    }
    
}
