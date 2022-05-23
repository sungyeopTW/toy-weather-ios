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
    
    func sendIsCelsius(isCelsius: Bool)
    
}


final class WeatherDetailViewController: UIViewController {
    
    weak var delegate: SendDataFromWeatherDetailViewController?
    
    var isCelsius = true
    
    
    // MARK: - Enum
    
    enum Text {
        static let navigationBarTitle = "날씨 상세정보 🏖"
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    
    // MARK: - UI
    lazy var weatherDetailCollectionView = UICollectionView(
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
    
    lazy var backButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "arrow.backward")
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabBackButton)
    }
    
    lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: Image.thermometer)
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tabThermometerButton)
    }
    
    
    // MARK: - Methods
    
    private func initialize() {
        self.view = self.weatherDetailCollectionView
        
        self.navigationItem.title = Text.navigationBarTitle
        self.navigationItem.leftBarButtonItem = self.backButton
        self.navigationItem.rightBarButtonItem = self.thermometerButton
        
        self.weatherDetailCollectionView.reloadData()
    }
    
    @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()
        self.weatherDetailCollectionView.reloadData()
    }
    
    @objc func tabBackButton(_ sender: UIBarButtonItem) {
        self.delegate?.sendIsCelsius(isCelsius: self.isCelsius)
        
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
        if indexPath.row == 0 {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WeatherDetailCollectionViewTemperatureCell",
                for: indexPath
            ) as? WeatherDetailCollectionViewTemperatureCell {
                cell.getData(self.isCelsius)
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WeatherDetailCollectionViewCell",
                for: indexPath
            ) as? WeatherDetailCollectionViewCell {
                cell.setupLabelText(indexPath: indexPath.row, isCelsius: self.isCelsius)
                
                return cell
            }
        }
        
        return UICollectionViewCell()
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
    
        return CGSize(width: width, height: indexPath.row == 0 ? width : 120)
    }
    
}
