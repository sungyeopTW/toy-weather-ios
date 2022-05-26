//
//  WeatherDetailViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import SnapKit
import Then


// MARK: - SendDataFromWeatherDetailViewController

protocol SendDataFromWeatherDetailViewController: AnyObject {
    
    func sendIsCelsiusAndBookmarked(_ isCelsius: Bool, _ isBookmarked: Bool, _ cellData: City)
    
}


final class WeatherDetailViewController: UIViewController {
    
    weak var delegate: SendDataFromWeatherDetailViewController?
    
    var locationData: City
    var isCelsius = true
    var isBookmarked = false
    
    
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
        $0.image = UIImage(systemName: Image.thermometer)
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
    
    @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()
        self.weatherDetailCollectionView.reloadData()
    }
    
    @objc func tabBackButton(_ sender: UIBarButtonItem) {
        self.delegate?.sendIsCelsiusAndBookmarked(self.isCelsius, self.isBookmarked, self.locationData)
        
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
            cell.getData(self.isCelsius, self.isBookmarked)
        
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WeatherDetailCollectionViewCell",
                for: indexPath
            ) as! WeatherDetailCollectionViewCell
            
            cell.setupLabelText(indexPath.row, self.isCelsius)
    
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

// MARK: - SendDataFromWeatherDetailCollectionViewCell

extension WeatherDetailViewController: SendDataFromWeatherDetailCollectionViewCell {

    // sendIsBookmarked
    func sendIsBookmarked(_ isBookmarked: Bool) {
        self.isBookmarked = isBookmarked
        
        self.weatherDetailCollectionView.reloadData()
    }

}
