//
//  SearchViewModel.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 20.04.2023.
//

import Foundation
import CoreLocation

protocol SearchViewModelProtocol: AnyObject {
    func reloadTable()
}

class SearchViewModel {
    
    var dataSource = SearchDataSource()
    
    weak var delegate: SearchViewModelProtocol?
    
    let locationManager = CLLocationManager()
}

extension SearchViewModel {
    
    func fetchLocationSetup() {
        
        if let location = locationManager.location {
            globalLat = location.coordinate.latitude.debugDescription
            globalLon = location.coordinate.longitude.debugDescription
        }
    }
    
    func fetchCitiesData(city: String) {
        
        WeatherManager.shared.getCitiesData(city: city) { [weak self] result in
            switch result {
            case .success(let cities):
                DispatchQueue.main.async {
                    self?.dataSource.searchCities = cities
                    self?.delegate?.reloadTable()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUserDefaults() {
        
        UserDefaultsManager.shared.userDefaultsFetch { cities in
            self.dataSource.favoriteCities = cities            
        }
    }
}
    
