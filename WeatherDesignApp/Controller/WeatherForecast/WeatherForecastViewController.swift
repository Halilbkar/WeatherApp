//
//  WeatherForecastViewController.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 15.04.2023.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "heroColor")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var weatherForecastTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(WeatherForecastTableViewCell.self, forCellReuseIdentifier: WeatherForecastTableViewCell.identifier)
        
        return table
    }()
    
    private lazy var weatherHero: WeatherForecastHeroUIView = {
        let view = WeatherForecastHeroUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var weatherProperty: WeatherPropertyUIView = {
        let view = WeatherPropertyUIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var viewModel = WeatherForecastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backImageView)
        addGradient()
        
        view.addSubview(weatherHero)
        view.addSubview(weatherProperty)
        view.addSubview(weatherForecastTableView)
        
        viewModel.delegate = self

        viewModel.dataSource.heroView = self.weatherHero
        viewModel.dataSource.propertyView = self.weatherProperty
        
        weatherForecastTableView.delegate = viewModel.dataSource
        weatherForecastTableView.dataSource = viewModel.dataSource
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        viewModel.dataSource.daily.removeAll()
        
        viewModel.fetchWeatherData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backImageView.frame = view.bounds
        
        let weatherHeroConstraints = [
            weatherHero.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherHero.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherHero.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherHero.heightAnchor.constraint(equalToConstant: 150)
            
        ]
        
        let weatherPropertyConstraints = [
            weatherProperty.topAnchor.constraint(equalTo: weatherHero.bottomAnchor, constant: 28),
            weatherProperty.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherProperty.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherProperty.heightAnchor.constraint(equalToConstant: 110)
        ]
        
        let weatherForecastTableViewConstraints = [
            weatherForecastTableView.topAnchor.constraint(equalTo: weatherProperty.bottomAnchor, constant: 20),
            weatherForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherForecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        
        NSLayoutConstraint.activate(weatherHeroConstraints)
        NSLayoutConstraint.activate(weatherPropertyConstraints)
        NSLayoutConstraint.activate(weatherForecastTableViewConstraints)
    }
    
    private func addGradient() {
        guard let heroColor = UIColor(named: "heroColor") else { return }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.white.cgColor,
            heroColor.cgColor
        ]
        gradientLayer.frame = backImageView.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension WeatherForecastViewController: WeatherForecastViewModelProtocol {
    
    func viewReload() {
        self.weatherForecastTableView.reloadData()
    }
}
