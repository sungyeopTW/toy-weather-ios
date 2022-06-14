//
//  RootViewController.swift
//  toy-weather-ios
//
//  Created by sungyeopTW on 2022/05/03.
//

import UIKit

import ReactorKit
import RxSwift
import RxDataSources

import SnapKit
import Then

final class RootViewController: UIViewController, ReactorKit.View {
    
    var disposeBag = DisposeBag()
    var isCelsius: Bool = UserDefaultManager.loadIsCelsius()

    enum Text {
        static let navigationBarTitle = "오늘의 날씨 정보 🧑🏻‍💼"
        static let searchControllerPlaceholder = "지역을 입력하세요 🗺"
    }
    
    private lazy var searchController = UISearchController().then {
        $0.searchBar.placeholder = Text.searchControllerPlaceholder
        $0.hidesNavigationBarDuringPresentation = true
    }

    private lazy var thermometerButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "thermometer")
        $0.style = .plain
        $0.target = self
        $0.action = #selector(tapThermometerButton)
    }
    
    private lazy var bookmarkTableView = UITableView().then {
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 80
        $0.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
    }
    
    private lazy var locationSearchTableView = UITableView().then {
        $0.separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        $0.rowHeight = 50
        $0.register(LocationSearchTableViewCell.self, forCellReuseIdentifier: "LocationSearchTableViewCell")
    }
    

    // MARK: - Bind
    
    func bind(reactor: RootViewReactor) {
        // didLoaded
        self.setupNavigationController()
        self.reactor?.action.onNext(.landing)
        
        // [searchController] 서치 시작
        self.searchController.searchBar.rx.textDidBeginEditing
            .map { _ in Reactor.Action.toggleSearch }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        // [searchController] 서치 중
        self.searchController.searchBar.rx.text
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { Reactor.Action.search($0!) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // [searchController] cancel 클릭
        self.searchController.searchBar.rx.cancelButtonClicked
            .map { _ in Reactor.Action.toggleSearch }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
            
        // [RootViewController.View] bind with `isSearchActive`
        reactor.state.map { $0.isSearchActive }
            .subscribe(onNext: {
                self.view = $0 == true ? self.locationSearchTableView : self.bookmarkTableView
            })
            .disposed(by: self.disposeBag)
        
        // [BookmarkTableView] bind with `bookmarkedCityList`
        reactor.state.map { $0.bookmarkedCityList }
            .bind(to: self.bookmarkTableView.rx.items(cellIdentifier: "BookmarkTableViewCell", cellType: BookmarkTableViewCell.self)) { index, item, cell in
                
                cell.temperatureLabel.text = item.weather.currentTemperature.convertWithFormat(self.isCelsius ? .celsius : .fahrenheit)
                cell.locationLabel.text = item.location
                cell.bookmarkButton.tintColor = item.isBookmarked ? .yellowBookmarkColor : .grayBookmarkColor
                
                // [BookmarkTableViewCell] 즐겨찾기 버튼
                cell.disposeBag = DisposeBag() /// 중복방지!
                cell.bookmarkButton.rx.tap
                    .map { _ in Reactor.Action.bookmark(item.id, nil) }
                    .bind(to: reactor.action)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: self.disposeBag)
        
        // [LocationSearchTableView] bind with `searchedCityList`
        reactor.state.map { $0.searchedCityList }
            .bind(to: self.locationSearchTableView.rx.items(cellIdentifier: "LocationSearchTableViewCell", cellType: LocationSearchTableViewCell.self)) { [weak self] index, item, cell in
                
                cell.locationLabel.text = item.location
                cell.bookmarkButton.tintColor = item.isBookmarked ? .yellowBookmarkColor : .grayBookmarkColor

                // [LocationSearchTableViewCell] 즐겨찾기 버튼
                cell.disposeBag = DisposeBag() /// 중복방지!
                cell.bookmarkButton.rx.tap
                    .map { _ in Reactor.Action.bookmark(item.id, self?.searchController.searchBar.text) }
                    .bind(to: reactor.action)
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Methods

    private func setupNavigationController() {
        self.navigationItem.title = Text.navigationBarTitle
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.rightBarButtonItem = self.thermometerButton
        self.navigationItem.searchController = self.searchController
    }
    
    @objc func tapThermometerButton(_ sender: UIBarButtonItem) {
        self.isCelsius.toggle()
        self.bookmarkTableView.reloadData()
        
        UserDefaultManager.saveIsCelsius(self.isCelsius) /// userDefault에 저장
    }
    
}
//     // MARK: - Methods
//     // 초단기예보 -- 현재기온
//     private func fetchUltraSrtData() {
//         WeatherManager.fetchUltraSrtData(bookmarkedCity) { [weak self] locationId, temperature, sky, windDirection, windSpeed in
//             self?.temperatureWithBookmarkedCityId[locationId] = temperature
//
//             DispatchQueue.main.async {
//                 self?.bookmarkTableView.reloadData()
//             }
//         }
//     }
//
//     // tabThermometerButton
//     @objc func tabThermometerButton(_ sender: UIBarButtonItem) {
//         self.isCelsius.toggle()
//         self.bookmarkTableView.reloadData()
//     }
//
// }
