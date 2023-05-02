//
//  WeatherHomeViewModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 9.04.2023.
//

import Foundation
import CoreLocation
import UIKit


protocol WeatherHomeViewModelProtocol: AnyObject {
    func viewReload()
    func setDailyData(daily: [Daily])
}

class WeatherHomeViewModel {
    
    public lazy var dataSource = WeatherHomeDataSource()
    weak var delegate: WeatherHomeViewModelProtocol?
    
    let locationManager = CLLocationManager()
}

extension WeatherHomeViewModel {
    
    func fetchLocationSetup() {
            
        if let location = locationManager.location {
            globalLat = location.coordinate.latitude.debugDescription
            globalLon = location.coordinate.longitude.debugDescription
        }
    }
    
    func fetchWeatherData() {
        guard let lat = globalLat, let lon = globalLon  else { return }
        
        WeatherManager.shared.getCurrentData(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let current):
                    self?.dataSource.current = current
                    self?.delegate?.viewReload()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        WeatherManager.shared.getDailyData(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let daily):
                    self?.delegate?.setDailyData(daily: daily)
                    self?.delegate?.viewReload()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        WeatherManager.shared.getHourlyData(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let hourly):
                    for indeks in 0...23 {
                        self?.dataSource.hourly.append(hourly[indeks])
                    }
                    self?.delegate?.viewReload()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

