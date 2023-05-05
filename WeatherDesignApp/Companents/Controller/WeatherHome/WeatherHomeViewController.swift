//
//  ViewController.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import UIKit
import CoreLocation

var globalLat:String?
var globalLon:String?
var globalName = ""

class WeatherHomeViewController: UIViewController {
    
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "Next Days"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherTodayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 110)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherHomeCollectionViewCell.self, forCellWithReuseIdentifier: WeatherHomeCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = viewModel.dataSource
        collectionView.dataSource = viewModel.dataSource
        
        return collectionView
    }()
    
    private lazy var weatherHero: WeatherHomeHeroUIView = {
        let view = WeatherHomeHeroUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var weatherProperty: WeatherPropertyUIView = {
        let view = WeatherPropertyUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var viewModel = WeatherHomeViewModel()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tappedSearch))
        
        addGradient()
        
        view.addSubview(weatherHero)
        view.addSubview(weatherProperty)
        view.addSubview(weatherTodayCollectionView)
        view.addSubview(daysLabel)
        view.addSubview(nextDaysLabel)
        
        viewModel.fetchLocationSetup()
        
        viewModel.delegate = self
        viewModel.dataSource.delegate = self
        weatherHero.delegate = self
                
        getNextDays()
        
        LocationManager.shared.setupLocation()
        LocationManager.shared.getCityName(nav: self.navigationItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = globalName
                
        viewModel.dataSource.hourly.removeAll()
        weatherHero.dailyArray.removeAll()
        
        viewModel.fetchWeatherData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            weatherHero.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherHero.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            weatherHero.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            weatherHero.heightAnchor.constraint(equalToConstant: 250),
            
            weatherProperty.topAnchor.constraint(equalTo: weatherHero.bottomAnchor, constant: 80),
            weatherProperty.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherProperty.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherProperty.heightAnchor.constraint(equalToConstant: 150),
            
            daysLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            daysLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            daysLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            nextDaysLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            nextDaysLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            nextDaysLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            weatherTodayCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 620),
            weatherTodayCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            weatherTodayCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            weatherTodayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4)
        ])
    }
    
    private func addGradient() {
        guard let heroColor = UIColor(named: "heroColor") else { return }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.white.cgColor,
            heroColor.cgColor
        ]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    @objc private func tappedSearch() {
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    private func getNextDays() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        nextDaysLabel.addGestureRecognizer(tapGestureRecognizer)
        nextDaysLabel.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped() {
        navigationController?.pushViewController(WeatherForecastViewController(), animated: true)
    }
}

extension WeatherHomeViewController: WeatherHomeViewModelProtocol {
    
    func viewReload() {
        self.weatherTodayCollectionView.reloadData()
        self.weatherHero.collectionViewReloadData()
    }
    
    func setDailyData(daily: [Daily]) {
        for indeks in 0...6 {
            self.weatherHero.dailyArray.append(daily[indeks])
        }
    }
}

extension WeatherHomeViewController: WeatherHomeDataSourceProtocol {
    
    func navigationPush() {
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension WeatherHomeViewController: WeatherHomeHeroUIViewProtocol {
    func configProperty(daily: Daily) {
        weatherProperty.configProperty(daily: daily)
    }
}
