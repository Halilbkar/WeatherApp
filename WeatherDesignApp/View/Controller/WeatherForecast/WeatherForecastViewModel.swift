//
//  WeatherForecastViewModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 16.04.2023.
//

import Foundation
import CoreLocation

protocol WeatherForecastViewModelProtocol: AnyObject {
    func viewReload()
}

class WeatherForecastViewModel {
    
    lazy var dataSource = WeatherForecastDataSource()
    
    weak var delegate: WeatherForecastViewModelProtocol?
    
    let locationManager = CLLocationManager()
}

extension WeatherForecastViewModel {
    
    func locationSetup(){
            
        if let location = locationManager.location {
            globalLat = location.coordinate.latitude.debugDescription
            globalLon = location.coordinate.longitude.debugDescription
        }
    }
    
    func fetchWeatherData() {
        
        guard let lat = globalLat, let lon = globalLon  else { return }
        
        WeatherManager.shared.getDailyData(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case.success(let daily):
                    for indeks in 0...6 {
                        self?.dataSource.daily.append(daily[indeks])
                    }
                    self?.delegate?.viewReload()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
