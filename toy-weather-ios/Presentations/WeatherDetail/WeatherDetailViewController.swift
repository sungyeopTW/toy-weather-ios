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
    
    var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
    }

    lazy var backButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "arrow.backward")
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabBackButton)
    }

    lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "thermometer")
        $0.style = .plain
        // $0.target = self
        // $0.action = #selector(tabThermometerButton)
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.titleView = self.titleLabel
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.thermometerButton
    }
    
    
    // MARK: - Bind
    
    func bind(reactor: WeatherDetailViewReactor) {
        
    }
    
    
    // MARK: - Methods
    
    @objc func tabBackButton(_ sender: UIBarButtonItem) {
        // self.delegate?.didTabTemperatureButton(self.isCelsius)
        // self.delegate?.didTabBookmarkButton(self.isBookmarked, on: self.locationData)

        self.navigationController?.popViewController(animated: true)
    }
    
}
    
//     weak var delegate: ButtonInteractionDelegate?
//
//     var locationData: City
//     var weatherData: [WeatherItem] = []
//
//     var isCelsius = true
//     var isBookmarked = false
//
//     private var weather = WeatherModel()
//
//
//     // MARK: - Life Cycle
//
//     init(_ locationData: City, _ isCelsius: Bool, _ isBookmarked: Bool) {
//         self.locationData = locationData
//         self.isCelsius = isCelsius
//         self.isBookmarked = isBookmarked
//
//         super.init(nibName: nil, bundle: nil)
//     }
//
//     required init?(coder: NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//
//     override func viewDidLoad() {
//         super.viewDidLoad()
//
//         self.initialize()
//
//         // self.fetchUltraSrtData()
//         self.fetchVilageData()
//     }
//
//
//     // MARK: - UI
//
//     private lazy var weatherDetailCollectionView = UICollectionView(
//         frame: .zero,
//         collectionViewLayout: UICollectionViewFlowLayout()
//     ).then {
//         $0.dataSource = self
//         $0.delegate = self
//         $0.register(
//             WeatherDetailCollectionViewTemperatureCell.self,
//             forCellWithReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell"
//         )
//         $0.register(
//             WeatherDetailCollectionViewCell.self,
//             forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell"
//         )
//     }
//
//     private var titleLabel = UILabel().then {
//         $0.font = .systemFont(ofSize: 20.0, weight: .bold)
//         $0.textColor = .black
//         $0.adjustsFontSizeToFitWidth = true
//     }
//
//     private lazy var backButton = UIBarButtonItem().then {
//         $0.image = UIImage(systemName: "arrow.backward")
//         $0.style = .plain
//         $0.target = self
//         $0.action = #selector(tabBackButton)
//     }
//
//     private lazy var thermometerButton = UIBarButtonItem().then {
//         $0.image = UIImage(systemName: "thermometer")
//         $0.style = .plain
//         $0.target = self
//         $0.action = #selector(tabThermometerButton)
//     }
//
//
//     // MARK: - Methods
//
//     private func initialize() {
//         self.view = self.weatherDetailCollectionView
//
//         self.titleLabel.text = self.locationData.location
//
//         self.navigationItem.largeTitleDisplayMode = .never
//         self.navigationItem.titleView = self.titleLabel
//         self.navigationItem.leftBarButtonItem = self.backButton
//         self.navigationItem.rightBarButtonItem = self.thermometerButton
//
//         self.weatherDetailCollectionView.reloadData()
//     }
//
//     초단기예보 -- for 하늘상태, 현재기온, 풍향, 풍속
//     private func fetchUltraSrtData() {
//         WeatherManager.fetchUltraSrtData([self.locationData]) { [weak self] locationId, temperature, sky, windDirection, windSpeed in
//             self?.weather.sky = sky
//             self?.weather.currentTemperature = temperature
//             self?.weather.windDirection = windDirection
//             self?.weather.windSpeed = windSpeed
//
//             DispatchQueue.main.async {
//                 self?.weatherDetailCollectionView.reloadData()
//             }
//         }
//     }
//
//     // 단기예보 -- for 최고기온, 최저기온, 강수확률
//     private func fetchVilageData() {
//         WeatherManager.fetchVilageData(self.locationData) { [weak self] highestTemperature, lowestTemperature, rainProbability in
//             self?.weather.highestTemperature = highestTemperature
//             self?.weather.lowestTemperature = lowestTemperature
//             self?.weather.rainProbability = rainProbability
//
//             DispatchQueue.main.async {
//                 self?.weatherDetailCollectionView.reloadData()
//             }
//         }
//     }
//
//     @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
//         self.isCelsius.toggle()
//         self.weatherDetailCollectionView.reloadData()
//     }
//
//     @objc func tabBackButton(_ sender: UIBarButtonItem) {
//         self.delegate?.didTabTemperatureButton(self.isCelsius)
//         self.delegate?.didTabBookmarkButton(self.isBookmarked, on: self.locationData)
//
//         self.navigationController?.popViewController(animated: true)
//     }
//
// }
//
//
// // MARK: - WeatherDetailCollectionViewDataSource
//
// extension WeatherDetailViewController: UICollectionViewDataSource {
//
//     // section 별 item 수
//     func collectionView(
//         _ collectionView: UICollectionView,
//         numberOfItemsInSection section: Int
//     ) -> Int {
//         4
//     }
//
//     // cell
//     func collectionView(
//         _ collectionView: UICollectionView,
//         cellForItemAt indexPath: IndexPath
//     ) -> UICollectionViewCell {
//         switch indexPath.row {
//         case 0:
//             let cell = collectionView.dequeueReusableCell(
//                 withReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell",
//                 for: indexPath
//             ) as! WeatherDetailCollectionViewTemperatureCell
//
//             cell.delegate = self
//             cell.updateCellWithDatas(
//                 self.isCelsius,
//                 self.isBookmarked,
//                 self.weather
//             )
//
//             return cell
//         default:
//             let cell = collectionView.dequeueReusableCell(
//                 withReuseIdentifier: "WeatherDetailCollectionViewCell",
//                 for: indexPath
//             ) as! WeatherDetailCollectionViewCell
//
//             cell.updateCellWithDatas(
//                 indexPath.row,
//                 self.isCelsius,
//                 self.weather
//             )
//
//             return cell
//         }
//     }
//
// }
//
//
// // MARK: - WeatherDetailCollectionViewDelegateFlowLayout
//
// extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout {
//
//     // item size
//     func collectionView(
//         _ collectionView: UICollectionView,
//         layout collectionViewLayout: UICollectionViewLayout,
//         sizeForItemAt indexPath: IndexPath
//     ) -> CGSize {
//         let width = collectionView.frame.width - 32.0
//
//         return CGSize(width: width, height: indexPath.row == 0 ? width + 32 : 120)
//     }
//
// }
//
//
// // MARK: - ButtonInteractionDelegate
//
// extension WeatherDetailViewController: ButtonInteractionDelegate {
//
//     func didTabBookmarkButton(_ isBookmarked: Bool, on cellData: City?) {
//         self.isBookmarked = isBookmarked
//
//         self.weatherDetailCollectionView.reloadData()
//     }
//
// }
