//
//  UserDefaultsManager.swift
//  WeatherDesignApp
//
//  Created by Halil Bakar on 28.04.2023.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    func userDefaultsAdd(cities: [Geonames]) {

        do {
            let citiesData = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(citiesData, forKey: "favCities")
            print("Add")
            print(cities)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func userDefaultsRemove(cities: inout [Geonames], favCities: Geonames) {

        UserDefaults.standard.removeObject(forKey: "favCities")

        if let index = cities.firstIndex(of: favCities) {
            cities.remove(at: index)
        }

        let citiesData = try! JSONEncoder().encode(cities)
        UserDefaults.standard.set(citiesData, forKey: "favCities")
        print("Remove")
        print(cities)
    }
    
    func userDefaultsFetch(completion: @escaping ([Geonames]) -> ()) {

        if let userCities = UserDefaults.standard.data(forKey: "favCities") {

            do {
                let cities = try JSONDecoder().decode([Geonames].self, from: userCities)
                completion(cities)
                print("fetch")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
